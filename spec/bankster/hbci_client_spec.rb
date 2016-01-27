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

  describe '#balances' do
    context 'when the bank supports the receiving of multiple balances' do
    end
  end
end

