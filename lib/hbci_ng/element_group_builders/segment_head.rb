module HbciNg
  module ElementGroupBuilder
    class SegmentHead
      def self.build
        ElementGroup.new('Segmentkopf') do |eg|
          eg.add_element(0, Element.new('Segmentkennung'))
          eg.add_element(1, Element.new('Segmentnummer'))
          eg.add_element(2, Element.new('Segmentversion'))
          eg.add_element(3, Element.new('Bezugssegment'))
        end
      end
    end
  end
end
