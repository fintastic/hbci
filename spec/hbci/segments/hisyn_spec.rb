require 'spec_helper'

describe 'HISYN' do
  describe Hbci::Segments::HISYNv4, type: :segment do
    describe '.fill' do
      let(:sample) { "HISYN:50:4:5+3709173969001000X093CQZRUROV04'" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets head' do
        expect(subject.head.type).to eql('HISYN')
        expect(subject.head.position).to eql('50')
        expect(subject.head.version).to eql('4')
        expect(subject.head.reference).to eql('5')
      end

      it 'sets elements' do
        expect(subject.system_id).to eql('3709173969001000X093CQZRUROV04')
        expect(subject.msg_number).to be_nil
        expect(subject.sec_ref_key).to be_nil
        expect(subject.sec_ref_sig).to be_nil
      end
    end

    describe '#compile' do
      it { expect(subject.to_s).to eql("HISYN:1:4'") }
    end
  end
end
