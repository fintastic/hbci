module Bankster
  module Hbci
    module Segments
      class HISALv3 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTO
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo
        element_group :pending, type: ElementGroups::Saldo
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
      end


      class HISALv4 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTO
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo
        element_group :pending, type: ElementGroups::Saldo
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element :timestamp_date
        element :timestamp_time

        def booked_amount
          sign = case booked.credit_debit
                 when 'C' then 1
                 when 'D' then -1
                 end
          sign * Monetize.parse(booked.btg_value, booked.btg_curr)
        end
      end

      class HISALv5 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV2
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo
        element_group :pending, type: ElementGroups::Saldo
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element :timestamp_date
        element :timestamp_time
        element :duedate
      end

      class HISALv6 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTV3
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo2
        element_group :pending, type: ElementGroups::Saldo2
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element_group :overdrive, type: ElementGroups::BTG
        element_group :timestamp, type: ElementGroups::Timestamp
        element :duedate
      end

      class HISALv7 < Segment
        element_group :head, type: ElementGroups::SegmentHead
        element_group :ktv, type: ElementGroups::KTVInt
        element :kontobez
        element :curr
        element_group :booked, type: ElementGroups::Saldo2
        element_group :pending, type: ElementGroups::Saldo2
        element_group :kredit, type: ElementGroups::BTG
        element_group :available, type: ElementGroups::BTG
        element_group :used, type: ElementGroups::BTG
        element_group :overdrive, type: ElementGroups::BTG
        element_group :timestamp, type: ElementGroups::Timestamp
        element :duedate
      end

    end
  end
end

