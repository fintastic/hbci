require 'optparse'
require 'active_support'
require 'active_support/core_ext'

options = {
  url: nil,
  bank_code: nil,
  user_id: nil,
  pin: nil
}

OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb acount_number [options]'

  opts.on '-url', '--url=URL', 'URL' do |arg|
    options[:url] = arg
  end

  opts.on '-b', '--bank_code=BANK_CODE', 'Bank code' do |arg|
    options[:bank_code] = arg
  end

  opts.on '-u', '--user_id=USER_ID', 'User id' do |arg|
    options[:user_id] = arg
  end

  opts.on '-p', '--pin=PIN', 'PIN' do |arg|
    options[:pin] = arg
  end

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end.parse!

@account_number = ARGV.at(0)
@credentials = Bankster::BankCredentials::Hbci.new(
  url: options[:url],
  bank_code: options[:bank_code],
  user_id: options[:user_id],
  pin: options[:pin]
)

raise 'missing account_number' unless @account_number

@client = Bankster::Hbci::Client.new(@credentials)
