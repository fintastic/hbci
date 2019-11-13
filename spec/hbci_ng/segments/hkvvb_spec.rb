require 'spec_helper_hbci_ng'

describe 'HKVVB' do
  describe HbciNg::Segments::HKVVBv3, type: :segment do
    let(:sample) { "HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'" }

    before do
    end

    it { expect(subject.to_hbci).to eql(sample) }
  end
end
