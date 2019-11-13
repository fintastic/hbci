# module HbciNg
#   class ElementGroup
#     attr_reader :segments
#
#     def initialize(data = nil)
#       @elements = []
#       @segments = []
#       fill(data) if data
#     end
#
#     def fill(data)
#       data = data.delete("\n").delete("\s")
#       if data[0] == '@'
#         cursor = 0
#         data.gsub!(/^@[0-9]*@/, '').each_char.with_index do |c, index|
#           next unless c == "'"
#
#           @segments << Segment.new(data[cursor..index])
#           cursor = index + 1
#         end
#       else
#         data.split(':').each { |e| @elements << Element.new(e) }
#       end
#     end
#
#     def encoded_data
#       @encoded_data.gsub(/^@[0-9]*@/, '')
#     end
#
#     def element(index)
#       @elements.fetch(index)
#     rescue IndexError
#       raise ElementError, "element on position #{index} does not exists"
#     end
#
#     def segment(index)
#       @segments.fetch(index)
#     rescue IndexError
#       raise ElementGroupError, "segment on position #{index} does not exists"
#     end
#
#     def to_hbci
#       hbci = String.new
#       if @segments.count > 0
#         hbci = @segments.map(&:to_hbci).join
#         hbci.insert(0, "@#{hbci.length}@")
#       end
#
#       @elements.each.with_index do |element, index|
#         hbci << element.to_hbci
#         hbci << ':' if index != @elements.length - 1
#       end
#       hbci
#     end
#   end
# end
