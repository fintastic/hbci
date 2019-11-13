# module HbciNg
#   class Element
#     attr_reader :description
#
#     def initialize(data)
#       fill(data) if data
#     end
#
#     def fill(data)
#       @value = data
#     end
#
#     def value=(value)
#       @value = value
#     end
#
#     def value
#       @value.to_s
#     end
#
#     def to_hbci
#       @value.to_s
#     end
#   end
# end
