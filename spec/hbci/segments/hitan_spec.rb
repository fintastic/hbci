# frozen_string_literal: true

require 'spec_helper'

describe 'HITAN' do
  describe Hbci::Segments::HITANv6, type: :segment do
    describe '.fill' do
      let(:sample) { "HITAN:5:6:5+4++000003Q9U0ANSIV6D4VFD7BMHLS35Uvb+Bitte TAN eingeben.'" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets head' do
        expect(subject.head.type).to eql('HITAN')
        expect(subject.head.position).to eql('5')
        expect(subject.head.version).to eql('6')
        expect(subject.head.reference).to eql('5')
      end

      it 'sets values' do
        expect(subject.tan_process).to eql('4')
        expect(subject.job_hash).to be_empty
        expect(subject.job_reference).to eql("000003Q9U0ANSIV6D4VFD7BMHLS35Uvb")
        expect(subject.challenge).to eql('Bitte TAN eingeben.')
        expect(subject.challenge_hhd_uc).to be_nil
        expect(subject.challenge_expiry).to be_nil
        expect(subject.tan_mechanism).to be_nil
      end
    end
  end
end
