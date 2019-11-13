require 'spec_helper_hbci_ng'

describe 'HKIDN' do
  describe HbciNg::Segments::HKIDNv2, type: :segment do
    let(:sample) { "HKIDN:3:2+280:74090000+186486386+0+1'" }

    before do
    end

    it { expect(subject.to_hbci).to eql(sample) }
  end
end
