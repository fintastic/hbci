require 'spec_helper_hbci_ng'

describe 'HNSHA' do
  describe HbciNg::Segments::HNSHAv2, type: :segment do
    let(:sample) { "HNSHA:6:2+3999997++111111'" }

    before do
    end

    it { expect(subject.to_hbci).to eql(sample) }
  end
end
