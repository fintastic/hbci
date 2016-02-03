require 'spec_helper'

describe Bankster::Hbci::Client do

  describe '#initialize' do
    describe 'checking of credentials' do
      let(:credentials) { 
        Bankster::BankCredentials::Hbci.new({
          url:        'https://hbci11.fiducia.de/cgi-bin/hbciservlet',
          bank_code:  '0000',
          user_id:    '1111',
          pin:        'pin'
        })
      }

      it 'fails with an error when not givven a Bankster::BankCredentials::Hbci object' do
        expect { described_class.new('doh!') }.
          to raise_error(ArgumentError, "#{described_class}#initialize expects a Bankster::BankCredentials::Hbci object")
      end

      it 'does not fail with an error when givven a bankster bank credentials hbci object' do
        expect { described_class.new(credentials) }.
          to_not raise_error
      end
    end
  end

  describe '#balance(account_number)' do
    let(:credentials) do
      Bankster::BankCredentials::Hbci.new({
        url:        'https://hbci11.fiducia.de/cgi-bin/hbciservlet',
        bank_code:  '0000',
        user_id:    '1111',
        pin:        'pin'
      })
    end

    let(:client) { described_class.new(credentials) }
    let(:dialog) { Bankster::Hbci::Dialog.new(credentials) }
    let(:messenger) { Bankster::Hbci::Messenger.new(dialog: dialog) }

    before do
      allow_any_instance_of(Bankster::Hbci::Messenger).to receive(:new).and_return(messenger)
      allow(client).to receive(:dialog).and_return(dialog)
    end

    it 'initiates the dialog' do
      # expect_any_instance_of(Bankster::Hbci::Dialog).to receive(:initiate).once

      # client.balance('123')
    end
  end
end

