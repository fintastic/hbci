# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Message do
  let(:sample) { nil }
  let(:segment_1) { Hbci::Segment.new.head('HTEST1', 999, 2) }
  let(:segment_2) { Hbci::Segment.new.head('HTEST2', 999, 2) }

  it 'returns hbci string' do
    segment_2.add_data_block(2, 'TEST-DATA-BLOCK')

    subject[1] = segment_1
    subject[2] = segment_2

    expect(subject.to_s).to eql("HTEST1:999:2'HTEST2:999:2+@15@TEST-DATA-BLOCK'")
  end

  describe '#find_segments' do
    before do
      subject[1] = segment_1
      subject[2] = segment_2
    end

    it 'returns segment' do
      expect(subject.find_segments('HTEST1')).to contain_exactly(segment_1)
    end
  end

  describe '#parse' do
    let(:sample) do
      sample = <<~HBCI
        HNHBK:1:3+000000000372+300+0+1'
        HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'
        HNVSD:999:1+@213@
          HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
          HKIDN:3:2+280:74090000+186486386+0+1'
          HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
          HKSYN:5:3+0'
          HNSHA:6:2+3999997++111111'
        '
        HNHBS:7:1+1'
      HBCI
      sample.delete("\n").delete("\s")
    end

    subject { described_class.parse(sample) }

    it 'returns value' do
      expect(subject[1].to_s).to eql("HNHBK:1:3+000000000372+300+0+1'")
      expect(subject[2].to_s).to eql("HNVSK:998:3+PIN:1+998+1+1::0+1:20190926:120916+2:2:13:@5@NOKEY:5:1+280:74090000:186486386:V:1:1+0'")
      expect(subject[3].to_s).to eql("HNVSD:999:1+@213@HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'HKIDN:3:2+280:74090000+186486386+0+1'HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'HKSYN:5:3+0'HNSHA:6:2+3999997++111111''")
      expect(subject[4].to_s).to eql("HNHBS:7:1+1'")
    end
  end
end
