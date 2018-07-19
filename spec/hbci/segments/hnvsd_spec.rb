# frozen_string_literal: true

require 'spec_helper'

describe 'HNVSD' do
  describe Hbci::Segments::HNVSDv1, type: :segment do
    describe '#compile' do
      before do
        subject.compile
      end

      it { expect(subject.to_s).to eql("HNVSD:999:1+@0@'") }
    end

    describe '.add_segment' do
      subject do
        Hbci::Segments::HNVSDv1.new do |s|
          s.add_segment(Hbci::Segments::HNSHKv4.new)
        end
      end

      it 'adds segment' do
        expect(subject.segments.size).to eql(1)
      end
    end

    describe '#add_segment' do
      it 'adds segment' do
        expect { subject.add_segment(Hbci::Segments::HNSHKv4.new) }.to change { subject.segments.size }.from(0).to(1)
      end
    end

    describe '.fill' do
      let(:sample) { "HNVSD:999:1+@76@HIRMG:2:2+9800::Dialogabbruch.'HIRMS:3:2:2+9210::Ung?ltige Kundensystem-ID.''" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets head' do
        expect(subject.head.type).to eql('HNVSD')
        expect(subject.head.position).to eql('999')
        expect(subject.head.version).to eql('1')
        expect(subject.head.reference).to be_nil
      end
    end
  end
end
