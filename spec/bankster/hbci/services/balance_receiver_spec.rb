require 'spec_helper'

describe Bankster::Hbci::Services::BalanceReceiver do
  let(:credentials)            { build(:hbci_credentials) }
  let(:start_date)             { Date.new(2016, 2, 18) }
  let(:end_date)               { Date.new(2016, 2, 20) }
  let(:account_number)         { '11111111' }
  let!(:dialog_init_request)   { stub_dialog_init_request(credentials) }
  let!(:dialog_finish_request) { stub_dialog_finish_request(credentials) }

  before do
    Timecop.freeze
    allow(Bankster::Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  let!(:balance_request) { stub_balance_request(credentials, account_number) }
  let!(:balance)         { described_class.perform(credentials, account_number) }

  it 'requests and returns the balance' do
    expect(dialog_init_request).to have_been_made.once
    expect(balance_request).to have_been_made.once
    expect(dialog_finish_request).to have_been_made.once
    expect(balance).to eql(Money.eur(4_202_830))
  end
end
