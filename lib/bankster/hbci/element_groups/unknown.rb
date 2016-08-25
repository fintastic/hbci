module Bankster
  module Hbci
    module ElementGroups
      class Unknown < ElementGroup
        99.times do |i|
          element :"entry_#{i}"
        end
      end
    end
  end
end
