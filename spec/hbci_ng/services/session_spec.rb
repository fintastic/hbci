require 'spec_helper_hbci_ng'

  # let(:request_sample) { "HNHBK:1:3+000000000372+300+0+1'HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'HNVSD:999:1+@213@HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'HKIDN:3:2+280:74090000+186486386+0+1'HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'HKSYN:5:3+0'HNSHA:6:2+3999997++111111''HNHBS:7:1+1'" }
describe HbciNg::Services::Session, type: :service do
  let(:credentials) { build(:hbci_credentials) }
  let(:connector) { Hbci::Connector.new(credentials) }

  let(:sample) do
    sample = <<~HBCI
      HNHBK:1:3+000000000372+300+0+1'
      HNVSK:998:3+PIN:1+998+1+1::0+1:20190925:090900+2:2:13:@5@NOKEY:5:1+280:74090000:22222222:V:1:1+0'
      HNVSD:999:1+@213@
        HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
        HKIDN:3:2+280:74090000+186486386+0+1'
        HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
        HKSYN:5:3+0'
        HNSHA:6:2+3999997++111111'
      '
      HNHBS:7:1+1'
    HBCI
    sample.delete("\n").delete("\s")
  end


  subject { described_class.new(connector) }


  it do
    puts subject.hbci_message.to_hbci
    # puts sample
  end

  # TODO: Die richtigen werte müssen gesetzt werden.
  # it { expect(subject.hbci_message.to_hbci).to eql(sample) }
end
