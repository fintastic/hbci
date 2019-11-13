# module HbciNg
#   class Value
#     def initialize(str = String.new)
#       @str = str
#     end
#
#     def <<(subject)
#       if subject.is_a?(Segment)
#         @str << '@0@' if @str.empty?
#         @str << subject.to_hbci
#         @str[1] = @str.length.to_s
#       else
#         @str << subject
#       end
#     end
#
#     def to_hbci
#       @str
#     end
#   end
# end
