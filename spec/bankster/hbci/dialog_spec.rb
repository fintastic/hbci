require 'spec_helper'

describe Bankster::Hbci::Dialog do
  describe 'initiate' do
    let(:credentials) do
      Bankster::BankCredentials::Hbci.new({
        url:        'https://hbci11.fiducia.de/cgi-bin/hbciservlet',
        bank_code:  '0000',
        user_id:    '1111',
        pin:        'pin'
      })
    end

    subject{ described_class.new(credentials) }


  end
end
