# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Services::TransactionsReceiver, type: :receiver do
  let(:start_date) { Date.new(2016, 2, 18) }
  let(:end_date) { Date.new(2016, 2, 20) }

  context 'when requested via hkkaz version 6' do
    let!(:transaction_request) { stub_transaction_v6_request(credentials, iban, start_date, end_date) }

    subject { Hbci::Services::TransactionsReceiver.new(dialog, iban, 6) }

    it 'returns the transactions' do
      transactions = subject.perform(start_date, end_date)

      expect(transaction_request).to have_been_made.once
      expect(transactions.count).to eql(1)
      expect(transactions[0]['amount_in_cents']).to eql(1833)
      expect(transactions[0]['swift_code']).to eql('NMSC')
    end
  end

  context 'when requested via hkkaz version 7' do
    let!(:transaction_request) { stub_transaction_v7_request(credentials, iban, start_date, end_date) }

    subject { Hbci::Services::TransactionsReceiver.new(dialog, iban, 7) }

    it 'returns the transactions when requested with hkkaz v7' do
      transactions = subject.perform(start_date, end_date)

      expect(transaction_request).to have_been_made.once
      expect(transactions.count).to eql(1)
      expect(transactions[0]['amount_in_cents']).to eql(1833)
      expect(transactions[0]['swift_code']).to eql('NMSC')
    end
  end

  context 'when requested via hkkaz verion 7 with pagination' do
    let!(:transaction_request_1) do
      stub_paginated_transaction_v7_request(credentials, iban, start_date, end_date, nil, 2, 2)
    end
    let!(:transaction_request_2) do
      stub_paginated_transaction_v7_request(credentials, iban, start_date, end_date, 2, 3, 3)
    end
    let!(:transaction_request_3) do
      stub_paginated_transaction_v7_request(credentials, iban, start_date, end_date, 3, nil, 4)
    end
    let!(:dialog_finish_request) { stub_dialog_finish_request(credentials, 5) }
    subject { Hbci::Services::TransactionsReceiver.new(dialog, iban, 7) }

    it 'returns the transactions when requested with hkkaz v7' do
      transactions = subject.perform(start_date, end_date)

      expect(transaction_request_1).to have_been_made.once
      expect(transaction_request_2).to have_been_made.once
      expect(transaction_request_3).to have_been_made.once
      expect(transactions.count).to eql(3)
      expect(transactions[0]['amount_in_cents']).to eql(1833)
      expect(transactions[0]['swift_code']).to eql('NMSC')
    end
  end
end
