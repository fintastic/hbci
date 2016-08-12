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
  end

  describe '#balance(account_number)' do
    let(:account_number)   { '11111111' }
    let!(:balance_request) { stub_balance_request(credentials, account_number) }
    let!(:balance)         { client.balance(account_number) }

    it 'requests and returns the balance' do
      expect(dialog_init_request).to have_been_made.once
      expect(balance_request).to have_been_made.once
      expect(dialog_finish_request).to have_been_made.once
      expect(balance).to eql(Money.eur(4_202_830))
    end
  end
end
