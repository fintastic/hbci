module Bankster
  module Hbci
    class Transformer < Parslet::Transform
      rule(element: simple(:element)) do |element|
        element[:element].to_s unless element[:element].nil?
      end

      rule(element_group: sequence(:element_group)) do |c|
        c[:element_group]
      end

      rule(element_group: simple(:element_group)) do |c|
        [c[:element_group]]
      end

      rule(segment: subtree(:segment)) do |s|
        s[:segment]
      end
    end
  end
end
