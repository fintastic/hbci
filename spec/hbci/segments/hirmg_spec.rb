require 'spec_helper'

describe 'HIRMG' do
  describe Hbci::Segments::HIRMGv2, type: :segment do
    describe '.fill' do
      let(:sample) { "HIRMG:2:2+9050::Teilweise fehlerhaft.'" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets head' do
        expect(subject.head.type).to eql('HIRMG')
        expect(subject.head.position).to eql('2')
        expect(subject.head.version).to eql('2')
        expect(subject.head.reference).to be_nil
      end

      it 'sets ret_val_1' do
        expect(subject.ret_val_1.code).to eql('9050')
        expect(subject.ret_val_1.ref).to be_empty
        expect(subject.ret_val_1.text).to eql('Teilweise fehlerhaft.')
        expect(subject.ret_val_1.parm).to be_nil
      end
    end
  end
end
