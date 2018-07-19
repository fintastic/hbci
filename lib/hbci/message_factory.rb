module Hbci
  module MessageFactory
    def self.build(dialog)
      request_message = Message.new(dialog)
      request_message.add_segment(Segments::HNHBKv3.new)
      request_message.add_segment(Segments::HNVSKv3.new)
      hnvsd = Segments::HNVSDv1.new do |s|
        s.add_segment(Segments::HNSHKv4.new)
        yield s
        s.add_segment(Segments::HNSHAv2.new)
      end
      request_message.add_segment(hnvsd)
      request_message.add_segment(Segments::HNHBSv1.new)
      request_message
    end
  end
end
