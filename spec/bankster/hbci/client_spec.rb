require 'spec_helper'

describe Bankster::Hbci::Client do
  describe '#initialize' do
    describe 'checking of credentials' do
      let(:credentials) do
        Bankster::BankCredentials::Hbci.new(url:        'https://hbci11.fiducia.de/cgi-bin/hbciservlet',
                                            bank_code:  '0000',
                                            user_id:    '1111',
                                            pin:        'pin')
      end

      it 'fails with an error when not givven a Bankster::BankCredentials::Hbci object' do
        expect { described_class.new('doh!') }
          .to raise_error(ArgumentError, "#{described_class}#initialize expects a Bankster::BankCredentials::Hbci object")
      end

      it 'does not fail with an error when givven a bankster bank credentials hbci object' do
        expect { described_class.new(credentials) }
          .to_not raise_error
      end
    end
  end

  describe '#transactions(account_number)' do
    let(:credentials) do
      Bankster::BankCredentials::Hbci.new(url:        'https://hbci11.fiducia.de/cgi-bin/hbciservlet',
                                          bank_code:  '11111111',
                                          user_id:    '22222222',
                                          pin:        '33333')
    end
    let(:client) { described_class.new(credentials) }

    before do
      Timecop.freeze
      allow(Bankster::Hbci::Message).to receive(:generate_security_reference).and_return('10999990')

      stub_request(:post, credentials.url)
        .with(body: Base64.encode64(stub_dialog_init_request(credentials)))
        .to_return(status: 200, body: Base64.encode64(stub_dialog_init_response(credentials)))

      stub_request(:post, credentials.url)
        .with(body: Base64.encode64(stub_transactions_request(credentials, account_number: '11111111', start_date: Date.new(2016, 2, 18), end_date: Date.new(2016, 2, 20))))
        .to_return(status: 200, body: Base64.encode64(stub_transactions_response(credentials, account_number: '11111111')))
    end
    after do
      Timecop.return
    end

    it 'returns the transactions' do
      transactions = client.transactions('11111111', Date.new(2016, 2, 18), Date.new(2016, 2, 20))
      expect(transactions.count).to eql(1)

      transaction = transactions.first
      expect(transaction['amount_in_cents']).to eql(1833)
      expect(transaction['swift_code']).to eql('NMSC')
    end
  end

  describe '#balance(account_number)' do
    let(:credentials) do
      Bankster::BankCredentials::Hbci.new(url:        'https://hbci11.fiducia.de/cgi-bin/hbciservlet',
                                          bank_code:  '22222222',
                                          user_id:    '11111111',
                                          pin:        '12345')
    end
    let(:client) { described_class.new(credentials) }

    before do
      Timecop.freeze
      allow(Bankster::Hbci::Message).to receive(:generate_security_reference).and_return('10999990')

      stub_request(:post, credentials.url)
        .with(body: Base64.encode64(stub_dialog_init_request(credentials)))
        .to_return(status: 200, body: Base64.encode64(stub_dialog_init_response(credentials)))

      stub_request(:post, credentials.url)
        .with(body: Base64.encode64(stub_balance_request(credentials, account_number: '11111111')))
        .to_return(status: 200, body: Base64.encode64(stub_balance_response(credentials, account_number: '11111111')))
    end

    after do
      Timecop.return
    end

    it 'receives the balance' do
      expect(client.balance('11111111')).to eql(
        '11111111' => Money.eur(4_202_830)
      )

      expect(
        a_request(:post, credentials.url)
        .with(body: Base64.encode64(stub_dialog_init_request(credentials)))
      ).to have_been_made.once

      expect(
        a_request(:post, credentials.url)
        .with(body: Base64.encode64(stub_balance_request(credentials, account_number: '11111111')))
      ).to have_been_made.once
    end
  end
end
