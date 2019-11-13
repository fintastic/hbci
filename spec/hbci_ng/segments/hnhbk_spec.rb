require 'spec_helper_hbci_ng'

describe 'HNHBK' do
  describe HbciNg::Segments::HNHBKv3, type: :segment do
    let(:sample) { "HNHBK:1:3:+000000000372+300+0+1+:'" }
  end
end
