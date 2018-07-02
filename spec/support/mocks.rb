# frozen_string_literal: true

def build(type, args: {})
  case type
  when :hbci_credentials
    build_hbci_credentials(args)
  end
end

def build_hbci_credentials(_args)
  BankCredentials::Hbci.new(
    url:        'https://hbci11.fiducia.de/cgi-bin/hbciservlet',
    bank_code:  '74090000',
    user_id:    '22222222',
    pin:        '33333'
  )
end
