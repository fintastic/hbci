# frozen_string_literal: true

require 'optparse'
require 'active_support'
require 'active_support/core_ext'

@options = {
  url: nil,
  hbci_version: nil,
  bank_code: nil,
  user_id: nil,
  pin: nil,
  tan: nil,
  system_id: 0
}

OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb iban [options]'

  opts.on '-v', '--hbci_version=VERSION', 'Version' do |arg|
    @options[:hbci_version] = arg
  end

  opts.on '-b', '--bank_code=BANK_CODE', 'Bank code' do |arg|
    @options[:bank_code] = arg
  end

  opts.on '-u', '--user_id=USER_ID', 'User id' do |arg|
    @options[:user_id] = arg
  end

  opts.on '-p', '--pin=PIN', 'PIN' do |arg|
    @options[:pin] = arg
  end

  opts.on '-t', '--tan=TAN', 'TAN' do |arg|
    @options[:tan] = arg
  end

  opts.on '-s', '--system_id=SYSTEM_ID', 'SYSTEM_ID' do |arg|
    @options[:system_id] = arg
  end

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end
end.parse!

@iban = ARGV.at(0)
raise 'missing iban' unless @iban

@hbci_version = @options[:hbci_version] ? @options[:hbci_version].to_i : nil
@credentials = BankCredentials::Hbci.new(
  bank_code: @options[:bank_code],
  user_id: @options[:user_id],
  pin: @options[:pin]
)
