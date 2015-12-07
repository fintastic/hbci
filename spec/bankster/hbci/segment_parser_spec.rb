require 'spec_helper'
describe Bankster::Hbci::SegmentParser do

  after(:each) do
    described_class.cleanup
  end

  describe '.register_segment' do
    let(:class_1) { Class.new(Bankster::Hbci::Segment) }
    let(:class_2) { Class.new(Bankster::Hbci::Segment) }

    it 'adds the segment to the list of registered segments' do
      described_class.register_segment(type: 'HNHBK', version: 1, class: class_1)
      described_class.register_segment(type: 'HNHBK', version: 2, class: class_2)

      expect(described_class.registered_segments).to eql([
        { type: 'HNHBK', version: 1, class: class_1 },
        { type: 'HNHBK', version: 2, class: class_2 }
      ])
    end
  end

  describe '.parse' do
    let(:sample) { "HNHBK:1:1+xxx'" }
    let(:segment_class) do 
      class MySegment < Bankster::Hbci::Segment
        element_group :head, elements: [:type, :position, :version]
        element :text
      end
      MySegment
    end

    before do
      described_class.register_segment(type: 'HNHBK', version: 1, class: segment_class)
    end
      
    subject { described_class.parse(sample) }

    it 'sets the attributes' do
      expect(subject.head.type).to eql('HNHBK')
      expect(subject.head.version).to eql('1')
      expect(subject.head.position).to eql('1')

      expect(subject.text).to eql('xxx')
    end

    it 'returns a segment class' do
      expect(subject).to be_a(MySegment)
    end

    it 'has 2 element groups' do
      expect(subject[0]).to be_a(Bankster::Hbci::ElementGroup)
      expect(subject[1]).to be_a(Bankster::Hbci::ElementGroup)
    end
  end
end

