# frozen_string_literal: true

require 'spec_helper'

describe 'HKKAZ' do
  let(:start_date) { Time.parse('01.01.2018') }
  let(:end_date) { Time.parse('03.01.2018') }

  describe Hbci::Segments::HKKAZv6, type: :segment do
    describe '#compile' do
      before do
        subject.account.number      = iban.extended_data.account_number
        subject.account.kik_blz     = iban.extended_data.bank_code
        subject.account.kik_country = 280
        subject.from                = start_date.strftime('%Y%m%d')
        subject.to                  = end_date.strftime('%Y%m%d')
      end

      let(:raw_segment) { "HKKAZ:1:6+11111111::280:74090000+N+20180101+20180103'" }

      it { expect(subject.to_s).to eql(raw_segment) }
    end
  end

  describe Hbci::Segments::HKKAZv7, type: :segment do
    describe '#compile' do
      before do
        subject.account.iban        = iban.to_s
        subject.account.bic         = iban.extended_data.bic
        subject.account.number      = iban.extended_data.account_number
        subject.account.kik_blz     = iban.extended_data.bank_code
        subject.account.kik_country = 280
        subject.from                = start_date.strftime('%Y%m%d')
        subject.to                  = end_date.strftime('%Y%m%d')
      end

      let(:raw_segment) { "HKKAZ:1:7+DE05740900000011111111:GENODEF1PA1:11111111::280:74090000+N+20180101+20180103'" }

      it { expect(subject.to_s).to eql(raw_segment) }
    end
  end
end
