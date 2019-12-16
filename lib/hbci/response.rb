# frozen_string_literal: true

module Hbci
  class Response
    def initialize(raw_response)
      @raw_response = raw_response.force_encoding('iso-8859-1')
    end

    def to_s
      @raw_response
    end
  end

  class SessionResponse < Response
    def initialize(raw_response)
      super
      @hbci_message = Message.new(@raw_response)
    end

    def hbci
      @hbci_message
    end

    def hnvsd
      @hbci_message.find_segments('HNVSD').first
    end

    def hnvsd_data_block
      Hbci::Message.new(hnvsd[2].to_s.sub(/@[0-9]+@/, ''))
    end
  end

  class DialogResponse < Response
    def initialize(raw_response)
      super
      @hbci_message = Message.new(@raw_response)
    end

    def hbci
      @hbci_message
    end

    def hnhbk
      @hbci_message.find_segments('HNHBK').first
    end

    def hnvsd
      @hbci_message.find_segments('HNVSD').first
    end

    def hnvsd_data_block
      Hbci::Message.new(hnvsd[2].to_s.sub(/@[0-9]+@/, ''))
    end
  end
end
