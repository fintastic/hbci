require 'spec_helper'

describe Hbci::Services::BalanceReceiver do
  let(:credentials) { build(:hbci_credentials) }
  let(:start_date) { Date.new(2016, 2, 18) }
  let(:end_date) { Date.new(2016, 2, 20) }
  let!(:dialog_init_request) { stub_dialog_init_request(credentials) }
  let!(:dialog_finish_request) { stub_dialog_finish_request(credentials) }
  let(:dialog) { Hbci::Dialog.new(credentials) }
  let(:iban) { 'DE05740900000011111111' }

  before do
    Timecop.freeze
    allow(Hbci::Message).to receive(:generate_security_reference).and_return('10999990')
  end

  before do
    dialog.initiate
  end

  after do
    dialog.finish
  end

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
