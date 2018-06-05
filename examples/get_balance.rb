require_relative '../lib/bankster/hbci'
require_relative 'credentials'

puts @client.balance(@account_number)
