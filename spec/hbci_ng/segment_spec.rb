# frozen_string_literal: true

require 'spec_helper_hbci_ng'

describe HbciNg::Segment do
  subject { described_class.new(sample) }

  let(:sample) { nil }

  it '#head' do
    subject.head('HTEST', 999,1)

    expect(subject.to_s).to eql("HTEST:999:1'")
  end

  it '#init' do
    subject.head('HTEST', 999,1)
    subject.init(['PIN', 1], nil, 300, 0, 1)

    expect(subject.to_s).to eql("HTEST:999:1+PIN:1++300+0+1'")
  end

  it '#add_data_block' do
    subject.head('HTEST', 999,1)
    subject.add_data_block(2, 'TEST')

    expect(subject.to_s).to eql("HTEST:999:1+@4@TEST'")
  end

  context 'with ter' do
    let(:sample) { 'HISYN:80:4:5+3g?+npy1a1m4BAAD26akuhm?+owAQA' }

    it 'returns value' do
      expect(subject[1].to_s).to eql('HISYN:80:4:5')
      expect(subject[2].to_s).to eql('3g?+npy1a1m4BAAD26akuhm?+owAQA')
    end
  end

  describe 'parse hbci string' do
    let(:sample) { 'TEST:1:11+3709173969001000X093CQZRUROV04+11:22' }

    it 'returns value' do
      expect(subject[1].to_s).to eql('TEST:1:11')
      expect(subject[2].to_s).to eql('3709173969001000X093CQZRUROV04')
      expect(subject[3][1]).to eql('11')
      expect(subject[3][2]).to eql('22')
    end

    context 'with hbci data block' do
      let(:sample) do
        sample = <<~HBCI
          HNVSD:999:1+@213@
            HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
            HKIDN:3:2+280:74090000+186486386+0+1'
            HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
            HKSYN:5:3+0'
            HNSHA:6:2+3999997++111111'
        HBCI
        sample.delete("\n").delete("\s")
      end

      it 'returns value' do
        expect(subject[1].to_s).to eql('HNVSD:999:1')
        expect(subject[2].to_s).to eql("@213@HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'HKIDN:3:2+280:74090000+186486386+0+1'HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'HKSYN:5:3+0'HNSHA:6:2+3999997++111111'")
      end
    end
  end
end
