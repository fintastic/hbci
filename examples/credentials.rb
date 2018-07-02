# frozen_string_literal: true

require 'optparse'
require 'active_support'
require 'active_support/core_ext'

options = {
  url: nil,
  hbci_version: nil,
  bank_code: nil,
  user_id: nil,
  pin: nil
}

OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb iban [options]'

  opts.on '-url', '--url=URL', 'URL' do |arg|
    options[:url] = arg
  end

  opts.on '-v', '--hbci_version=VERSION', 'Version' do |arg|
    options[:hbci_version] = arg
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

@iban = ARGV.at(0)
@hbci_version = options[:hbci_version] ? options[:hbci_version].to_i : nil
@credentials = BankCredentials::Hbci.new(
  url: options[:url],
  bank_code: options[:bank_code],
  user_id: options[:user_id],
  pin: options[:pin]
)

raise 'missing iban' unless @iban
