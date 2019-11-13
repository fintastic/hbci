require 'spec_helper_hbci_ng'

describe HbciNg::Subject do
  describe '#to_hbci' do
    let(:sample) { 'TEST:1:11:5' }

    before do
      subject.fill(sample)
    end

    it { expect(subject.to_hbci).to eql(sample) }

    describe 'change data' do
      let(:expected_sample) { 'TEST:111:11:5' }

      before do
        subject.find_by_index(1).value = '111'
      end

      it { expect(subject.to_hbci).to eql(expected_sample) }
    end

    context 'with binary data' do
      let(:sample) do
        sample = <<~HBCI
          @213@
            HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
            HKIDN:3:2+280:74090000+186486386+0+1'
            HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
            HKSYN:5:3+0'
            HNSHA:6:2+3999997++111111'
        HBCI
        sample.delete("\n").delete("\s")
      end

      it { expect(subject.to_hbci).to eql("@213@#{sample}") }
    end
  end
end
