# Hbci

A pure ruby HBCI client for talking with german banks

[![Gem Version](https://badge.fury.io/rb/hbci.svg)](https://badge.fury.io/rb/hbci)
[![Build Status](https://travis-ci.org/fintastic/hbci.svg?branch=master)](https://travis-ci.org/fintastic/hbci)
[![Depfu](https://badges.depfu.com/badges/9be5e8286939565cd257add25432b1a8/count.svg)](https://depfu.com/github/fintastic/hbci?project=Bundler)


## Preface

This gem is considered experimental.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hbci'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hbci

## Usage

First, setup your credentials in a `BankCredentials::Hbci` instance:
```ruby
credentials = BankCredentials::Hbci.new({
  url:        'url',
  bank_code:  'bank_code',
  user_id:    'user_id',
  pin:        'pin'
})
```

Now, you can receive your balances, accounts and transactions:

### Receiving the transactions

```ruby
iban = 'DE05740900000011111111'
start_date = 3.day.ago
end_date = Time.now

Hbci::Dialog.open(credentials) do |dialog|
  transactions = Hbci::Services::TransactionsReceiver.new(dialog, iban).perform(start_date, end_date)
  transactions.each do |transaction|
    puts transaction
  end
end
```

### Receiving a balance

```ruby
iban = 'DE05740900000011111111'

Hbci::Dialog.open(credentials) do |dialog|
  puts Hbci::Services::BalanceReceiver.new(dialog, iban).perform
end
```

### Receiving the accounts

```ruby
Hbci::Dialog.open(credentials) do |dialog|
  accounts = Hbci::Services::AccountsReceiver.new(dialog).perform
  accounts.each do |account|
    puts account
  end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fintastic/hbci


## Hbci Documentation

* [FinTS 3.0 Formals](http://www.hbci-zka.de/dokumente/spezifikation_deutsch/fintsv3/FinTS_3.0_Formals_2017-10-06_final_version.pdf)
* [FinTS 3.0 Messages](https://www.hbci-zka.de/dokumente/spezifikation_deutsch/fintsv3/FinTS_3.0_Messages_Geschaeftsvorfaelle_2015-08-07_final_version.pdf)
* [FinTS 3.0 Sicherheitsverfahren](https://www.hbci-zka.de/dokumente/spezifikation_deutsch/fintsv3/FinTS_3.0_Security_Sicherheitsverfahren_HBCI_Rel_20130718_final_version.pdf)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
