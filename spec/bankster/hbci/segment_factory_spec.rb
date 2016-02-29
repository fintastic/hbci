require 'spec_helper'

describe Bankster::Hbci::SegmentFactory do

  describe '.build' do
    context 'when given a valid segment' do
      let(:segment_data) { [['TESTCLASS', :_, '1' ]] }
      let!(:segment_class) do
        Class.new(Bankster::Hbci::Segment) do
          def self.type
            'TESTCLASS'
          end

          def self.version
            '1'
          end
        end
      end

      it 'returns an instance of the matching segment class' do
        expect(segment_class).to receive(:parse)

        described_class.build(segment_data)
      end
    end

    context 'when given a valid segment but there is no candidate' do
      let(:segment_data) { [['TESTCLASSXY', :_, '1' ]] }

      it 'builds and returns an unknown segment' do
        # expect(described_class.build(segment_data)).to be_a(Bankster::Hbci::Segments::Unknown)
      end
    end

    context 'when given a valid segment and multiple candidates' do
      let(:segment_data) { [['TESTCLASS', :_, '1' ]] }
      let!(:segment_class_1) do
        Class.new(Bankster::Hbci::Segment) do
          def self.type
            'TESTCLASS'
          end

          def self.version
            '1'
          end
        end
      end

      let!(:segment_class_2) do
        Class.new(Bankster::Hbci::Segment) do
          def self.type
            'TESTCLASS'
          end

          def self.version
            '1'
          end
        end
      end

      it 'raises an ambiguous error' do
        expect(segment_class_1).to_not receive(:parse)
        expect(segment_class_2).to_not receive(:parse)

        expect { described_class.build(segment_data) }
          .to raise_error('Ambiguous class candidates for TESTCLASS in version 1')
      end
    end
  end
end
