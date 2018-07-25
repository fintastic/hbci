# frozen_string_literal: true

module Hbci
  module Segments
    class HIRMSv2 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      1.upto(99) do |i|
        element_group "ret_val_#{i}".to_sym, type: ElementGroups::RetVal
      end

      def allowed_tan_mechanism
        groups_with_status_code = element_groups.select { |eg| eg.respond_to?(:code) && eg.code == '3920' }
        groups_with_status_code.first.parm if groups_with_status_code.any?
      end
    end
  end
end
