# frozen_string_literal: true

module Hbci
  class Dialog
    attr_reader :id
    attr_reader :tan
    attr_reader :hbci_version
    attr_reader :system_id
    attr_reader :tan_mechanism
    attr_reader :security_function
    attr_reader :response
    attr_reader :connector
    attr_reader :hikazs_versions
    attr_reader :hisals_versions

    def self.open(connector, system_id: 0, tan: nil)
      dialog = Dialog.new(connector, system_id: system_id, tan: tan)
      dialog.initiate
      yield dialog
      dialog.finish
    end

    def initialize(connector, system_id: 0, tan: nil)
      @connector = connector
      @initiated = false
      @hbci_version = '3.0'
      @system_id = system_id
      @tan = tan
      @tan_mechanism = nil
      @job_reference = nil
      @security_function = nil
      @id = 0
      @response = nil
      @hikazs_versions = []
      @hisals_versions = []
    end

    def credentials
      @connector.credentials
    end

    def initiated?
      @initiated
    end

    def initiate_session
      Hbci.logger.info('Start initiating FinTS/HBCI session')

      request_message = Message.new(@connector, nil)
      request_message.add_segment(Segments::HNHBKv3.new)
      hnvsk = Segments::HNVSKv3.new
      hnvsk.security_profile.version = 1
      request_message.add_segment(hnvsk)
      hnvsd = Segments::HNVSDv1.new do |s|
        hnshk = Segments::HNSHKv4.new
        hnshk.tan_mechanism = 999
        hnshk.security_profile.version = 1
        s.add_segment(hnshk)

        s.add_segment(Hbci::Segments::HKIDNv2.new)
        s.add_segment(Hbci::Segments::HKVVBv3.new)
        s.add_segment(Hbci::Segments::HKSYNv3.new)
        s.add_segment(Hbci::Segments::HNSHAv2.new)
      end
      request_message.add_segment(hnvsd)
      request_message.add_segment(Segments::HNHBSv1.new)
      request_message.compile

      response = Response.new(connector.post(request_message, false))
      raise DialogError.new('Session Initialization failed', response.to_s) unless initialization_successful?(response)

      @system_id = response.find('HNVSD').find('HISYN').system_id
      @security_function = response.find('HNVSD').find('HITANS').second_factor_params.security_function
      @tan_mechanism = response.find('HNVSD').find('HITANS').second_factor_params.tan_mechanism
      @hikazs_versions = response.find('HNVSD').find_all('HIKAZS').map { |x| x.head.version.to_i }
      @hisals_versions = response.find('HNVSD').find_all('HISALS').map { |x| x.head.version.to_i }

      Hbci.logger.info('Finish initiating FinTS/HBCI session')
    end

    def initiate_dialog
      Hbci.logger.info('Start initiating dialog')
      request_message = Message.new(@connector, self)
      request_message.add_segment(Segments::HNHBKv3.new)

      hnvsk = Segments::HNVSKv3.new
      hnvsk.security_profile.version = 2
      request_message.add_segment(hnvsk)
      hnvsd = Segments::HNVSDv1.new do |s|
        hnshk = Segments::HNSHKv4.new
        hnshk.tan_mechanism = @security_function
        hnshk.security_profile.version = 2
        s.add_segment(hnshk)

        s.add_segment(Segments::HKIDNv2.new)
        s.add_segment(Segments::HKVVBv3.new)

        hktan = Segments::HKTANv6.new
        hktan.tan_mechanism = 4
        hktan.seg_id = 'HKIDN'
        s.add_segment(hktan)

        s.add_segment(Segments::HNSHAv2.new)
      end
      request_message.add_segment(hnvsd)
      request_message.add_segment(Segments::HNHBSv1.new)
      request_message.compile

      @response = Response.new(@connector.post(request_message))

      raise DialogError.new('Dialog initialization failed', @response.to_s) unless initialization_successful?(@response)

      @id = @response.find('HNHBK').dialog_id
      @job_reference = @response.find('HNVSD').find('HITAN').job_reference
      @initiated = true
      Hbci.logger.info('Finish initiating dialog')
    end

    def initiate_tan
      Hbci.logger.info('Start initiating tan')
      request_message = Message.new(@connector, self)
      request_message.add_segment(Segments::HNHBKv3.new)
      hnvsk = Segments::HNVSKv3.new
      hnvsk.security_profile.version = 2
      request_message.add_segment(hnvsk)
      hnvsd = Segments::HNVSDv1.new do |s|
        hnshk = Segments::HNSHKv4.new
        hnshk.tan_mechanism = @security_function
        hnshk.security_profile.version = 2
        s.add_segment(hnshk)

        hktan = Segments::HKTANv6.new
        hktan.tan_mechanism = @tan_mechanism
        hktan.job_reference = @job_reference
        hktan.next_tan = 'N'
        s.add_segment(hktan)

        hnsha = Segments::HNSHAv2.new
        hnsha.signature.tan = @tan
        s.add_segment(hnsha)
      end
      request_message.add_segment(hnvsd)
      request_message.add_segment(Segments::HNHBSv1.new)

      request_message.compile
      Response.new(connector.post(request_message))
      Hbci.logger.info('Finish initiating tan')
    end

    def initiate
      initiate_session
      # initiate_dialog
      # initiate_tan if @tan
    end

    def finish
      Hbci.logger.info('finish dialog')
      request_message = MessageFactory.build(@connector, self) do |hnvsd|
        hnvsd.add_segment(Segments::HKENDv1.new)
      end
      request_message.compile

      @connector.post(request_message)
      @connector.reset_message_number
    end

    private

    def initialization_successful?(response)
      hirmg = response.find('HIRMG')
      return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

      hnvsd = response.find('HNVSD')
      hirmg = hnvsd.find('HIRMG')
      return false if hirmg && hirmg.ret_val_1.code[0].to_i == 9

      true
    end
  end
end
