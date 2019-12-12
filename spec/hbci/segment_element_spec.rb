# frozen_string_literal: true

require 'spec_helper'

describe Hbci::SegmentElement do
  subject { described_class.new(sample) }

  let(:sample) { 'TEST:1:11' }

  it 'returns value' do
    expect(subject[1]).to eql('TEST')
    expect(subject[2]).to eql('1')
    expect(subject[3]).to eql('11')
  end

  context 'with array' do
    let(:sample) { ['TEST', 1, 11] }

    it 'returns value' do
      expect(subject.to_s).to eql('TEST:1:11')
      expect(subject[1]).to eql('TEST')
      expect(subject[2]).to eql('1')
      expect(subject[3]).to eql('11')
    end
  end

  context 'with hbci data block' do
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

    it 'returns value' do
      expect(subject.to_s).to eql("@213@HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'HKIDN:3:2+280:74090000+186486386+0+1'HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'HKSYN:5:3+0'HNSHA:6:2+3999997++111111'")
    end
  end
end

