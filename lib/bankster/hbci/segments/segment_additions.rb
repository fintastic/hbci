module Bankster
  module Hbci
    module Segments
      class HISALv4 < Segment
        def booked_amount
          sign = case booked.credit_debit
                 when "C" then 1
                 when "D" then -1
                 end
          sign * Money.new(booked.btg_value.gsub(',',''), booked.btg_curr)
        end
      end
      class HIRMSv2 < Segment
        def allowed_tan_mechanism
          groups_with_status_code = element_groups.select{ |eg| eg.respond_to?(:code) && eg.code == "3920" }
          groups_with_status_code.first.parm if groups_with_status_code.any?
        end
      end
    end
  end
end
