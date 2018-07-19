# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Services::BalanceReceiver, type: :receiver do
  let(:start_date) { Date.new(2016, 2, 18) }
  let(:end_date) { Date.new(2016, 2, 20) }

  context 'when requested via hksal version 4' do
    let!(:balance_request) { stub_balance_v4_request(credentials, iban) }

    context 'when given an account number that is accessible' do
      subject { Hbci::Services::BalanceReceiver.new(dialog, iban, 4) }

      it 'requests and returns the balance' do
        balance = subject.perform

        expect(balance).to eql(Money.eur(4_202_830))
        expect(balance_request).to have_been_made.once
      end
    end
  end

  context 'when requested via hksal version 6' do
    let!(:balance_request) { stub_balance_v6_request(credentials, iban) }

    context 'when given an account number that is accessible' do
      subject { Hbci::Services::BalanceReceiver.new(dialog, iban, 6) }

      it 'requests and returns the balance' do
        balance = subject.perform

        expect(balance).to eql(Money.eur(4_202_830))
        expect(balance_request).to have_been_made.once
      end
    end
  end

  context 'when requested via hksal version 7' do
    let!(:balance_request) { stub_balance_v7_request(credentials, iban) }

    context 'when given an account number that is accessible' do
      subject { Hbci::Services::BalanceReceiver.new(dialog, iban, 7) }

      it 'requests and returns the balance' do
        balance = subject.perform

        expect(balance).to eql(Money.eur(4_202_830))
        expect(balance_request).to have_been_made.once
      end
    end
  end
end
