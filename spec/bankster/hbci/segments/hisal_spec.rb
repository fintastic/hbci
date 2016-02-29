require 'spec_helper'

describe Bankster::Hbci::Segments::HISALv4 do
  let(:segment) { described_class.new }
  describe '#booked_amount' do
    it 'retrns the correct money object' do
      segment.booked.credit_debit = "C"
      segment.booked.btg_value = "2,13"
      segment.booked.btg_curr = "EUR"

      expect(segment.booked_amount).to eql(Money.eur(213))


      segment.booked.credit_debit = "D"
      segment.booked.btg_value = "2,13"
      segment.booked.btg_curr = "EUR"

      expect(segment.booked_amount).to eql(- Money.eur(213))


      segment.booked.credit_debit = "D"
      segment.booked.btg_value = "2,3"
      segment.booked.btg_curr = "EUR"

      expect(segment.booked_amount).to eql(- Money.eur(230))


      segment.booked.credit_debit = "C"
      segment.booked.btg_value = "2"
      segment.booked.btg_curr = "EUR"

      expect(segment.booked_amount).to eql(Money.eur(200))
    end
  end
end
