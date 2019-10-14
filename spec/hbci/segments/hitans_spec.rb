# frozen_string_literal: true

require 'spec_helper'

describe 'HITAN' do
  describe Hbci::Segments::HITANSv6, type: :segment do
    describe '.fill' do
      let(:sample) { "HITANS:17:6:4+1+1+0+J:N:1:900:2:MS1.0.0:photoTAN::SecurePlus:8:1:Secure Plus TAN:999:J:1:N:0:0:N:J:00:0:J:1'" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets head' do
        expect(subject.head.type).to eql('HITANS')
        expect(subject.head.position).to eql('17')
        expect(subject.head.version).to eql('6')
        expect(subject.head.reference).to eql('4')
      end

      it 'sets values' do
        puts Hbci::Parser.parse(sample).first.inspect

        expect(subject.max_jobs).to eql('1')
        expect(subject.amount_sig).to eql('1')
        expect(subject.security_class).to eql('0')
        expect(subject.second_factor_params.one_factor_allowed).to eql('J')
        expect(subject.second_factor_params.multi_tan_allowed).to eql('N')
        expect(subject.second_factor_params.job_reference).to eql('1')
        expect(subject.second_factor_params.security_function).to eql('900')
        expect(subject.second_factor_params.tan_mechanism).to eql('2')
      end
    end
  end
end
