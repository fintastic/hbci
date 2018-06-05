require_relative '../lib/bankster/hbci'
require_relative 'credentials'

start_date = 1.month.ago
end_date = Time.now

@client.transactions(@acount_number, start_date, end_date).each do |transaction|
  puts transaction
end
