module Hbci
  module Segments
    class HIUPDv5 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element_group :ktv, type: ElementGroups::KTV2
      element :customerid
      element :acctype
      element :cur
      element :name1
      element :name2
      element :konto
      element_group :k_limit, type: ElementGroups::KLimit
      10.times do |i|
        element_group "allowed_gv_#{i}".to_sym, type: ElementGroups::AllowedGV
      end
    end

    class HIUPDv6 < Segment
      element_group :head, type: ElementGroups::SegmentHead
      element_group :ktv, type: ElementGroups::KTV2
      element :iban
      element :user_id
      element :account_type
      element :currency
      element :name_1
      element :name_2
      element :konto
      element_group :k_limit, type: ElementGroups::KLimit
      999.times do |i|
        element_group "allowed_gv_#{i}".to_sym, type: ElementGroups::AllowedGV
      end
      element :accountdata
    end
  end
end
