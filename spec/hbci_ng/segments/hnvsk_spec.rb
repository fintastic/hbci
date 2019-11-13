require 'spec_helper_hbci_ng'

describe 'HNVSK' do
  describe HbciNg::Segments::HNVSKv3, type: :segment do
    let(:sample) { "HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'" }

    before do
      # subject.fill(sample)
    end

    it 'test' do
      puts described_class.find_by_name('Schlüsselname').find_by_name('Kreditinstitutskennung')
    end


    # it { expect(subject.to_hbci).to eql(sample) }
  end
end
