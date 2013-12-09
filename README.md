# Braspag

Provides an easier Ruby integration with the Braspag payment gateway using SOAP.

## Installation

Add this line to your application Gemfile:

```bash
gem 'braspag'
```

And then execute:

```bash
$ bundle
```

Or install it yourself with:

```bash
$ gem install braspag
```

## How it works

Braspag gem currently supports 4 types of transactions so far:

### Authorization (AuthorizeTransaction WSDL method)

Designated to handle several types of transactions (credit card, bank slip, etc).

### Capture

### Cancel


### Refund
TODO - not implemented


TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
