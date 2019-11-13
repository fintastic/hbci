require 'spec_helper_hbci_ng'

describe 'HKSYN' do
  describe HbciNg::Segments::HKSYNv3, type: :segment do
    let(:sample) { "HKSYN:5:3+0'" }

    before do
    end

    it { expect(subject.to_hbci).to eql(sample) }
  end
end
