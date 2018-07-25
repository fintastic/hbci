require 'spec_helper'

describe 'HISAL' do
  describe Hbci::Segments::HISALv4, type: :segment do
    describe '.fill' do
      let(:sample) { "HISAL:5:4:3+11111111:280:74090000+Kontokorrent+EUR+C:42028,3:EUR:20160219'" }

      subject { described_class.fill(Hbci::Parser.parse(sample).first) }

      it 'sets header element_group' do
        expect(subject.head.type).to eql('HISAL')
        expect(subject.head.position).to eql('5')
        expect(subject.head.version).to eql('4')
        expect(subject.head.reference).to eql('3')
      end

      it 'sets ktv element_group' do
        expect(subject.ktv.number).to eql('11111111')
        expect(subject.ktv.country).to eql('280')
        expect(subject.ktv.blz).to eql('74090000')
      end
    end

    describe '#booked_amount' do
      subject { described_class.new }

      it 'returns the correct money object' do
        subject.booked.credit_debit = 'C'
        subject.booked.btg_value = '2,13'
        subject.booked.btg_curr = 'EUR'

        expect(subject.booked_amount).to eql(Money.eur(213))

        subject.booked.credit_debit = 'D'
        subject.booked.btg_value = '2,13'
        subject.booked.btg_curr = 'EUR'

        expect(subject.booked_amount).to eql(-Money.eur(213))

        subject.booked.credit_debit = 'D'
        subject.booked.btg_value = '2,3'
        subject.booked.btg_curr = 'EUR'

        expect(subject.booked_amount).to eql(-Money.eur(230))

        subject.booked.credit_debit = 'C'
        subject.booked.btg_value = '2'
        subject.booked.btg_curr = 'EUR'

        expect(subject.booked_amount).to eql(Money.eur(200))
      end
    end
  end
end
