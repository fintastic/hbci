require 'spec_helper'

describe Hbci::Services::Session, type: :service do
  subject { described_class.new(connector) }

  let(:iban) { 'DE05740900000011111111' }
  let(:connector) { Hbci::Connector.new(iban) }

  before do
    Hbci.configure do |config|
      config.product_name = 'TEST-PRODUCT-NAME'
      config.user_id = 'TEST-USER-ID'
      config.pin = 'TEST-PIN'
    end
  end

  let(:sample) do
    sample = <<~HBCI
      HNHBK:1:3+000000000407+300+0+1'
      HNVSK:998:3+PIN:1+998+1+1::0+1:20190925:090900+2:2:13:@5@NOKEY:5:1+280:74090000:TEST-USER-ID:V:1:1+0'
      HNVSD:999:1+@257@
        HNSHK:2:4+PIN:1+999+TEST-SECURITY-REFERENCE+1+1+1::0+2+1:20190925:090900+1:999:1+6:10:16+280:74090000:TEST-USER-ID:S:0:0'
        HKIDN:3:2+280:74090000+TEST-USER-ID+0+1'
        HKVVB:4:3+0+0+1+TEST-PRODUCT-NAME+0.3.5'
        HKSYN:5:3+0'
        HNSHA:6:2+TEST-SECURITY-REFERENCE++TEST-PIN'
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
