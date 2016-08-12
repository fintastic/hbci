require 'spec_helper'

describe Bankster::Hbci::Client do
  let(:credentials)            { build(:hbci_credentials) }
  let(:client)                 { described_class.new(credentials) }
  let!(:dialog_init_request)   { stub_dialog_init_request(credentials) }
  let!(:dialog_finish_request) { stub_dialog_finish_request(credentials) }

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
    let(:account_number) { double }
    let(:start_date) { double }
    let(:end_date) { double }
    let(:service_class) { Bankster::Hbci::Services::TransactionsReceiver }
    let(:transactions) { double }

    before { allow(service_class).to receive(:perform).and_return(transactions) }

    it 'calls the service' do
      expect(client.transactions(account_number, start_date, end_date, 6)).to eql(transactions)

      expect(service_class).to have_received(:perform).with(credentials, account_number, start_date, end_date, 6)
    end
  end

  describe '#balance(account_number)' do
    let(:account_number) { double }
    let(:balance) { double }
    let(:service_class) { Bankster::Hbci::Services::BalanceReceiver }

    before { allow(service_class).to receive(:perform).and_return(balance) }

    it 'calls the service' do
      expect(client.balance(account_number)).to eql(balance)

      expect(service_class).to have_received(:perform).with(credentials, account_number)
    end
  end

  describe '#accounts' do
    let(:service_class) { Bankster::Hbci::Services::AccountsReceiver }
    let(:accounts) { double }

    before { allow(service_class).to receive(:perform).and_return(accounts) }

    it 'calls the service' do
      expect(client.accounts).to eql(accounts)

      expect(service_class).to have_received(:perform).with(credentials)
    end
  end
end
