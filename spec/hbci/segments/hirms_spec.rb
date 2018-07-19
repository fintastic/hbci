require 'spec_helper'

describe 'HIRMS' do
  describe Hbci::Segments::HIRMSv2, type: :segment do
    describe '.fill' do
      let(:sample) { "HIRMS:3:2:998+9130:8,2:Inhalt syntaktisch ung�ltig.'" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets head' do
        expect(subject.head.type).to eql('HIRMS')
        expect(subject.head.position).to eql('3')
        expect(subject.head.version).to eql('2')
        expect(subject.head.reference).to eql('998')
      end

      it 'sets ret_val_1' do
        expect(subject.ret_val_1.code).to eql('9130')
        expect(subject.ret_val_1.ref).to eql('8,2')
        expect(subject.ret_val_1.text).to eql('Inhalt syntaktisch ung�ltig.')
        expect(subject.ret_val_1.parm).to be_nil
      end
    end
  end
end
