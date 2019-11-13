module HbciNg
  module Segments
    class HNHBKv3
      include SegmentSchema

      add('Nachrichtengröße')
      add('HBCI-Version')
      add('Dialog-ID')
      add('Nachrichtennummer')

      add('Bezugsnachricht') do |eg|
        eg.add('Dialog-ID')
        eg.add('Nachrichtennummer')
      end
    end
  end
end
