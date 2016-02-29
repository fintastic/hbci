require 'rake'
require 'open-uri'
require 'nokogiri'
require 'byebug'
require 'active_support/all'

class Nokogiri::XML::Document
  def remove_empty_lines!
    xpath('//text()').each { |text| text.content = text.content.gsub(/\n(\s*\n)+/, "\n")  }; self
  end
end

desc 'Generates segments'
task :generate_segment_classes do
  url = 'https://raw.githubusercontent.com/willuhn/hbci4java/master/src/hbci-300.xml'

  doc = Nokogiri::XML(open(url)) do |config|
    config.strict.noblanks.noent
  end

  def element_definition(element_node)
    { name: element_node.attr(:name) }
  end

  segments = doc.css('SEGdef').map do |segdef|
    segment = {}
    segment[:name] = segdef.css("value[path='SegHead.code']").text
    segment[:version] = segdef.css("value[path='SegHead.version']").text
    segment[:elements] = segdef.children.select { |c| c.name == 'DE' || c.name == 'DEG' }.map do |child|
      if child.name == 'DE'
        el = { type: :element, name: child.attr(:name) }
      elsif child.name == 'DEG'
        el = { type: :element_group, name: child.attr(:name) ? child.attr(:name) : child.attr(:type), eg: child.attr(:type), maxnum: child.attr(:maxnum).to_i }
      end
      el
    end
    segment
  end

  used_element_groups = []
  s = ''
  s << "module Bankster\n"
  s << "  module Hbci\n"
  s << "    module Segments\n"
  segments.select { |s| s[:name].match(/^HI.*/)  }.each do |seg|
    s << "      class #{seg[:name]}v#{seg[:version]} < Segment\n"
    seg[:elements].each do |el|
      if el[:type] == :element
    s << "        element :#{el[:name].underscore.gsub('.', '_')}\n"
      elsif el[:type] == :element_group
        if el[:name] == 'SegHead'
          s << "        element_group :head, type: ElementGroups::SegmentHead\n"
        else
          used_element_groups << el[:eg]
          if el[:maxnum].is_a?(Integer) && el[:maxnum] > 1
          s << "        #{el[:maxnum]}.times do |i|\n"
          s << "          element_group \"#{el[:name].underscore.gsub('.', '_')}_\#{i}\".to_sym, type: ElementGroups::#{el[:eg].camelize}\n"
          s << "        end\n"
          else
          s << "        element_group :#{el[:name].underscore.gsub('.', '_')}, type: ElementGroups::#{el[:eg].camelize}\n"
          end
        end
      end
    end
    s << "      end\n"
    s << "\n"
  end
  s << "    end\n"
  s << "  end\n"
  s << "end\n"

  File.open('lib/bankster/hbci/segments/param_segments_generated.rb', 'w') { |file| file.write(s)  }

  # Generate ElementGroups
  element_groups = doc.css('DEGdef').map do |degdef|
    element_group = {}
    element_group[:name] = degdef.attr(:id)
    element_group[:elements] = degdef.children.select { |c| c.name == 'DE' || c.name == 'DEG' }.map do |child|
      if child.name == 'DE'
        element_definition(child)
      elsif child.name == 'DEG'
        doc.css("DEGdef##{child.attr(:type)}").children.select { |c| c.name == 'DE' }.map { |c| element_definition(c) }
      else
        next
      end
    end
    element_group[:elements].flatten!
    element_group
  end

  s = ''
  s << "module Bankster\n"
  s << "  module Hbci\n"
  s << "    module ElementGroups\n"
  element_groups.select { |eg| used_element_groups.include?(eg[:name])}.each do |eg|
    s << "      class #{eg[:name].camelize} < ElementGroup\n"
    eg[:elements].each do |el|
      s << "        element :#{el[:name].underscore.gsub('.', '_')}\n"
    end
    s << "      end\n"
    s << "\n"
  end
  s << "    end\n"
  s << "  end\n"
  s << "end\n"
  File.open('lib/bankster/hbci/element_groups/generated_element_groups.rb', 'w') { |file| file.write(s)  }
end
