require 'spec_helper'

describe Bankster::Hbci::SegmentFactory do
  describe '.build' do
    context 'when given a valid segment' do
      let(:segment_data) { [['HNHBK', :_, '3']] }

      it 'returns an instance of the matching segment class' do
        expect(Bankster::Hbci::Segments::HNHBKv3).to receive(:fill)

        described_class.build(segment_data)
      end
    end

    context 'when given a valid segment but there is no candidate' do
      let(:segment_data) { [%w(TESTCLASSXY adad 1)] }

      it 'builds and returns an unknown segment' do
        expect(described_class.build(segment_data)).to be_a(Bankster::Hbci::Segments::Unknown)
      end
    end
  end
end
