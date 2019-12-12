require 'spec_helper'

describe Hbci::Services::BalanceReceiver, type: :service do
  subject { described_class.new(connector) }

  let(:session_response_sample) { response_sample('spec/fixtures/vr_session_init_response.hbci') }
  let(:dialog_response_sample) { response_sample('spec/fixtures/vr_dialog_init_response.hbci') }

  before do
    connector.session_service_response = session_response_sample
    connector.dialog_service_response = dialog_response_sample
    connector.message_number = 2
  end

  let(:sample) do
    sample = <<~HBCI
      HNHBK:1:3+000000000455+300+ID9120615224563+2'
      HNVSK:998:3+PIN:2+998+1+1::DP5O7JcE1m4BAAD26akuhm?+owAQA+1:20190925:090900+2:2:13:@5@NOKEY:5:1+280:74090000:TEST-USER-ID:V:1:1+0'
      HNVSD:999:1+@263@
        HNSHK:2:4+PIN:2+942+TEST-SECURITY-REFERENCE+1+1+1::DP5O7JcE1m4BAAD26akuhm?+owAQA+2+1:20190925:090900+1:999:1+6:10:16+280:74090000:TEST-USER-ID:S:0:0'
        HKSAL:3:7+DE05740900000011111111:GENODEF1PA1:11111111::280:74090000+N'
        HNSHA:4:2+TEST-SECURITY-REFERENCE++TEST-PIN'
      '
      HNHBS:7:1+1'
    HBCI
    sample.delete("\n").delete("\s")
  end

  before do
    allow_any_instance_of(described_class).to receive(:generate_security_reference).and_return('TEST-SECURITY-REFERENCE')
  end

  it { expect(subject.hbci_message.to_s).to eql(sample) }
end
