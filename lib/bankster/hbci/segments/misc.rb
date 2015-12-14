module Bankster
  module Hbci
    module Segments
      module MultiDiretDebitParams
        def self.included(klass)
          klass.element :max_number_of_transactions
          klass.element :min_number_of_usage
          klass.element :key
        end
      end
    end
  end
end
