require 'spec_helper'

describe Bankster::Hbci::Segments::HNSHKv4 do
  subject { described_class.new }

  describe 'default values' do
    before do
      Timecop.freeze
    end
    after do
      Timecop.return
    end
    it 'sets te correct default values' do
      expect(subject.security_profile.method).to eql('PIN')
      expect(subject.security_profile.version).to eql(1)
      expect(subject.security_function_code).to eql(999)
      expect(subject.area_of_security_application).to eql(1)
      expect(subject.role_of_security_supplier).to eql(1)
      expect(subject.security_identification_details.type).to eql(1)
      expect(subject.security_reference_number).to eql(1)
      expect(subject.secured_at.identifier).to eql(1)
      expect(subject.secured_at.date).to eql(Time.now.strftime("%Y%m%d"))
      expect(subject.secured_at.time).to eql(Time.now.strftime("%H%m%S"))

      expect(subject.hash_alg.usage).to eql(1)
      expect(subject.hash_alg.code).to eql(999)
      expect(subject.hash_alg.param_code).to eql(1)

      expect(subject.sig_alg.usage).to eql(6)
      expect(subject.sig_alg.code).to eql(10)
      expect(subject.sig_alg.operation_mode).to eql(16)

      expect(subject.key.bank_country_code).to eql(280)
      expect(subject.key.type).to eql("S")
      expect(subject.key.version).to eql(0)
      expect(subject.key.number).to eql(0)
    end
  end
end
