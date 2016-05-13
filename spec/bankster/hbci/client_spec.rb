require 'spec_helper'

describe Bankster::Hbci::Client do
  let(:credentials)          { build(:hbci_credentials) }
  let(:client)               { described_class.new(credentials) }
  let!(:dialog_init_request) { stub_dialog_init_request(credentials) }

  before do
    Timecop.freeze
    allow(Bankster::Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  describe '#initialize' do
    describe 'checking of credentials' do
      it 'fails with an error when not givven a Bankster::BankCredentials::Hbci object' do
        expect { described_class.new('doh!') }
        .to raise_error(ArgumentError, "#{described_class}#initialize expects a Bankster::BankCredentials::Hbci object")
      end

      it 'does not fail with an error when givven a bankster bank credentials hbci object' do
        expect { described_class.new(credentials) }.to_not raise_error
      end
    end
  end

  describe '#transactions(account_number, start_date, end_date, version)' do
    let(:start_date)     { Date.new(2016, 2, 18) }
    let(:end_date)       { Date.new(2016, 2, 20) }
    let(:account_number) { '11111111' }

    context 'when requested via hkkaz version 6' do
      let!(:transaction_request) { stub_transaction_v6_request(credentials, account_number, start_date, end_date) }
      let!(:transactions)        { client.transactions(account_number, start_date, end_date) }

      it 'returns the transactions when requested with hkkaz v6' do
        expect(transaction_request).to have_been_made.once

        expect(transactions.count).to eql(1)
        expect(transactions[0]['amount_in_cents']).to eql(1833)
        expect(transactions[0]['swift_code']).to eql('NMSC')
      end
    end

    context 'when requested via hkkaz version 7' do
      let!(:transaction_request) { stub_transaction_v7_request(credentials, account_number, start_date, end_date) }
      let!(:transactions)        { client.transactions(account_number, start_date, end_date, 7) }

      it 'returns the transactions when requested with hkkaz v7' do
        expect(transaction_request).to have_been_made.once
        expect(transactions.count).to eql(1)
        expect(transactions[0]['amount_in_cents']).to eql(1833)
        expect(transactions[0]['swift_code']).to eql('NMSC')
      end
    end
  end

  describe '#balance(account_number)' do
    let(:account_number)   { '11111111' }
    let!(:balance_request) { stub_balance_request(credentials, account_number) }
    let!(:balance)         { client.balance(account_number) }

    it 'initiates the dialog' do
      expect(dialog_init_request).to have_been_made.once
    end

    it 'requests the balance' do
      expect(balance_request).to have_been_made.once
    end

    it 'returns the balance' do
      expect(balance).to eql(account_number => Money.eur(4_202_830))
    end
  end
end