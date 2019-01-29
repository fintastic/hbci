# frozen_string_literal: true

require 'spec_helper'

describe 'HKSAL' do
  let(:account_number) { 111_111 }
  let(:account_code) { 222_222 }

  describe Hbci::Segments::HKSALv4, type: :segment do
    describe '#compile' do
      before do
        subject.account.number = account_number
        subject.account.code = account_code
      end

      it { expect(subject.to_s).to eql("HKSAL:1:4+111111:280:222222+N'") }
    end
  end

  describe Hbci::Segments::HKSALv5, type: :segment do
    describe '#compile' do
      before do
        subject.account.number = account_number
        subject.account.kik_blz = account_code
      end

      it { expect(subject.to_s).to eql("HKSAL:1:5+111111::280:222222+N'") }
    end
  end

  describe Hbci::Segments::HKSALv6, type: :segment do
    describe '#compile' do
      before do
        subject.account.number = account_number
        subject.account.kik_blz = account_code
      end

      it { expect(subject.to_s).to eql("HKSAL:1:6+111111::280:222222+N'") }
    end
  end

  describe Hbci::Segments::HKSALv7, type: :segment do
    describe '#compile' do
      before do
        subject.account.iban        = iban.to_s
        subject.account.bic         = iban.extended_data.bic
        subject.account.kik_blz     = iban.extended_data.bank_code
        subject.account.kik_country = 280
        subject.account.number      = iban.extended_data.account_number
      end

      it { expect(subject.to_s).to eql("HKSAL:1:7+DE05740900000011111111:GENODEF1PA1:11111111::280:74090000+N'") }
    end
  end
end
