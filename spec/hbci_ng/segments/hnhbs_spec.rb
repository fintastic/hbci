require 'spec_helper_hbci_ng'

describe 'HNHBS' do
  describe HbciNg::Segments::HNHBSv1, type: :segment do
    let(:sample) { "HNHBS:7:1+1'" }

    before do
    end

    it { expect(subject.to_hbci).to eql(sample) }
  end
end
