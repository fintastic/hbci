# frozen_string_literal: true

require 'spec_helper_hbci_ng'

module HbciNg
  module Segments
    class TESTv11
      include SegmentSchema

      add('Test-ID')
    end
  end
end

describe HbciNg::Segment do
  before do
    subject.fill(sample)
  end

  describe '#find_by_name' do
    let(:sample) { "TEST:1:11:5+3709173969001000X093CQZRUROV04'" }

    it { expect(subject.find_by_name('Test-ID').value).to eql('3709173969001000X093CQZRUROV04') }
    it { expect(subject.find_by_name('Segmentkopf/Segmentversion').value).to eql('11') }
  end

  describe '#find_by_index' do
    let(:sample) { "TEST:1:11:5+3709173969001000X093CQZRUROV04'" }

    it { expect(subject.find_by_index(1).value).to eql('3709173969001000X093CQZRUROV04') }
    it { expect(subject.find_by_index(0).find_by_index(2).value).to eql('11') }
  end

  describe '#to_hbci' do
    let(:sample) { "TEST:1:11:5+3709173969001000X093CQZRUROV04'" }

    it { expect(subject.to_hbci).to eql(sample) }

    describe 'change data' do
      let(:expected_sample) { "TEST:111:11:5+3709173969001000X093CQZRUROV04'" }

      before do
        subject.find_by_index(0).find_by_index(1).value = '111'
      end

      it { expect(subject.to_hbci).to eql(expected_sample) }
    end

    context 'with binary data' do
      let(:sample) do
        sample = <<~HBCI
          HNVSD:999:1+@213@
            HNSHK:2:4+PIN:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
            HKIDN:3:2+280:74090000+186486386+0+1'
            HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
            HKSYN:5:3+0'
            HNSHA:6:2+3999997++111111'
          '
        HBCI
        sample.delete("\n").delete("\s")
      end

      it { expect(subject.to_hbci).to eql(sample) }

      describe 'extract binary data' do
        let(:sample) do
          sample = <<~HBCI
            HNVSD:999:1+@213@
              HNSHK:2:4+PIN:2+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
              HKIDN:3:2+280:74090000+186486386+0+1'
              HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
              HKSYN:5:3+0'
              HNSHA:6:2+3999997++111111'
            '
          HBCI
          sample.delete("\n").delete("\s")
        end

        let(:expected_sample) do
          sample = <<~HBCI
            HNVSD:999:1+@216@
              HNSHK:2:4+SECRET:1+999+3999997+1+1+1::0+2+1:20190926:120916+1:999:1+6:10:16+280:74090000:186486386:S:0:0'
              HKIDN:3:2+280:74090000+186486386+0+1'
              HKVVB:4:3+0+0+1+FintasticHBCI+0.3.5'
              HKSYN:5:3+0'
              HNSHA:6:2+3999997++111111'
            '
          HBCI
          sample.delete("\n").delete("\s")
        end

        it 'changes data' do
          bin_hbci = subject.find_by_index(1).value

          hbci_message = HbciNg::Message.new(bin_hbci)
          hbci_message.segment(0).find_by_index(1).find_by_index(0).value = 'SECRET'
          hbci_message.segment(0).find_by_index(1).find_by_index(1).value = '1'

          subject.find_by_index(1).value = hbci_message.to_hbci

          expect(subject.to_hbci).to eql(expected_sample)
        end
      end
    end
  end
end
