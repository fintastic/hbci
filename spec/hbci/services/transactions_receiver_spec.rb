# frozen_string_literal: true

require 'spec_helper'

describe Hbci::Services::TransactionsReceiver, type: :receiver do
  let(:start_date) { Date.new(2016, 2, 18) }
  let(:end_date) { Date.new(2016, 2, 20) }

  context 'when requested via hkkaz version 6' do
    let!(:transaction_request) { stub_transaction_v6_request(credentials, iban, start_date, end_date) }

    subject { Hbci::Services::TransactionsReceiver.new(connector, dialog, iban, 6) }

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

    subject { Hbci::Services::TransactionsReceiver.new(connector, dialog, iban, 7) }

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
    subject { Hbci::Services::TransactionsReceiver.new(connector, dialog, iban, 7) }

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

  describe 'all versions' do
    context 'when no transactions are available' do
      let(:response) do
        msg = String.new
        msg << "HNHBK:1:3+000000000309+300+000003TU5CTH5TQR8K9HFAJ9CVEJS7+2+000003TU5CTH5TQR8K9HFAJ9CVEJS7:2'"
        msg << "HNVSK:998:3+PIN:1+998+1+2::0+1+2:2:13:@8@:6:1+280:76030080:910489735001:V:0:0+0'"
        msg << "HNVSD:999:1+@99@"
        msg << "HIRMG:2:2:+3060::Teilweise liegen Warnungen/Hinweise vor.'"
        msg << "HIRMS:3:2:3+3010::Keine Umsatze gefunden''"
        msg << "HNHBS:4:1+2'"
        msg
      end

      subject { Hbci::Services::TransactionsReceiver.new(connector, dialog, iban, 7) }

      before do
        stub_request(:post, credentials.url).to_return(status: 200, body: Base64.encode64(response))
      end

      it 'returns nothing' do
        transactions = subject.perform(start_date, end_date)

        expect(transactions.count).to eql(0)
      end
    end
  end
end
