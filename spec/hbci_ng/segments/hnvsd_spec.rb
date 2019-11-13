require 'spec_helper_hbci_ng'

describe 'HNVSD' do
  describe HbciNg::Segments::HNVSDv1, type: :segment do
    let(:sample) { "HNVSD:999:1+@213@HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'" }

    before do
    end

    it { expect(subject.to_hbci).to eql(sample) }
  end
end
