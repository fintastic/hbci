# Bankster::Hbci

A pure ruby HBCI client for talking with german banks

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bankster-hbci'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bankster-hbci

## Usage

First, setup your credentials in a `Bankster::BankCredentials::Hbci` instance:
```ruby
credentials = Bankster::BankCredentials::Hbci.new({
  url:        'url',
  bank_code:  'bank_code',
  user_id:    'user_id',
  pin:        'pin'
})
```

Now, you can receive your balances, accounts and transactions:

### Receiving the transactions

```ruby
client = Bankster::Hbci::Client.new(credentials)

transactions = client.transactions('account_number')
```

### Receiving a balance

```ruby
client = Bankster::Hbci::Client.new(credentials)

balance = client.balance('account_number')
```

### Receiving the accounts

```ruby
client = Bankster::Hbci::Client.new(credentials)

client.accounts
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bankster/bankster-hbci.


## Documents

https://www.hbci-zka.de/dokumente/spezifikation_deutsch/fintsv3/FinTS_3.0_Messages_Geschaeftsvorfaelle_2015-08-07_final_version.pdf

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

