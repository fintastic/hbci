require 'ruby-prof'
class DevelopmentProfiler

  def self.prof(file_name)

    RubyProf.start
    yield
    results = RubyProf.stop

    base_path = 'tmp'

    # Print a flat profile to text
    File.open "#{base_path}/#{file_name}-graph.html", 'w' do |file|
      RubyProf::GraphHtmlPrinter.new(results).print(file)
    end

    File.open "#{base_path}/#{file_name}-flat.txt", 'w' do |file|
      # RubyProf::FlatPrinter.new(results).print(file)
      RubyProf::FlatPrinterWithLineNumbers.new(results).print(file)
    end

    File.open "#{base_path}/#{file_name}-stack.html", 'w' do |file|
      RubyProf::CallStackPrinter.new(results).print(file)
    end

  end

end
