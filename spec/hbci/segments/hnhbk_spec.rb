# frozen_string_literal: true

require 'spec_helper'

describe 'HNHBK' do
  describe Hbci::Segments::HNHBKv3, type: :segment do
    describe '.fill' do
      let(:sample) { "HNHBK:1:3+xxx'" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets header element_group' do
        expect(subject.head.type).to eql('HNHBK')
        expect(subject.head.position).to eql('1')
        expect(subject.head.version).to eql('3')
        expect(subject.head.reference).to be_nil
      end
    end

    describe '#compile' do
      it { expect(subject.to_s).to eql("HNHBK:1:3+000000000000+300+0+1'") }
    end
  end
end
