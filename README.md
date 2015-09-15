# BitPay Library for Ruby

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://raw.githubusercontent.com/bitpay/ruby-cli/master/LICENSE.md)
[![Travis](https://img.shields.io/travis/bitpay/ruby-cli.svg?style=flat-square)](https://travis-ci.org/bitpay/ruby-cli)
[![Gem](https://img.shields.io/gem/v/bitpay-client.svg?style=flat-square)](https://rubygems.org/gems/bitpay-client)
[![Coveralls](https://img.shields.io/coveralls/bitpay/ruby-cli.svg?style=flat-square)](https://coveralls.io/github/bitpay/ruby-cli)
[![Code Climate](https://img.shields.io/codeclimate/github/bitpay/ruby-cli.svg?style=flat-square)](https://codeclimate.com/github/bitpay/ruby-cli)

Powerful, flexible, lightweight interface to the BitPay Bitcoin Payment Gateway API.

## Installation

    gem install bitpay-client

In your Gemfile:

    gem 'bitpay-client', :require => 'bitpay'

Or directly:

    require 'bitpay'

## Configuration

The bitpay client creates a cryptographically secure connection to your server by pairing an API code with keys stored on your server. The library generates the keys as a .pem file, which is stored in `$HOME/.bitpay/bitpay.pem` or preferentially in an environment variable.

The client will generate a key when initialized if one does not already exist.

## Basic Usage

### Pairing with Bitpay.com

To pair with bitpay.com you need to have an approved merchant account.  
1. Login to your account  
2. Navigate to bitpay.com/api-tokens (Dashboard > My Account > API Tokens)  
3. Copy an existing pairing code or create a new token and copy the pairing code.  
4. Use the bitpay command line tool to pair with bitpay.com `bitpay pair <pairing_code>`

### To create an invoice with a paired client:

The command line utility will save a PEM file in the file $HOME/.bitpay/bitpay.pem. When creating new clients, this pem file is needed in order to have an authorized client.

    client = BitPay::Client.new(pem: File.read("#{ENV['HOME']}/.bitpay/bitpay.pem"))
    invoice = client.create_invoice (id: <id>, price: <price>, currency: <currency>, facade: <facade>)

With invoice creation, `price` and `currency` are the only required fields. If you are sending a customer from your website to make a purchase, setting `redirectURL` will redirect the customer to your website when the invoice is paid.

Response will be a hash with information on your newly created invoice. Send your customer to the `url` to complete payment:

    {
      "id"             => "DGrAEmbsXe9bavBPMJ8kuk",
      "url"            => "https://bitpay.com/invoice?id=DGrAEmbsXe9bavBPMJ8kuk",
      "status"         => "new",
      "btcPrice"       => "0.0495",
      "price"          => 10,
      "currency"       => "USD",
      "invoiceTime"    => 1383265343674,
      "expirationTime" => 1383266243674,
      "currentTime"    => 1383265957613
    }

There are many options available when creating invoices, which are listed in the [BitPay API documentation](https://bitpay.com/bitcoin-payment-gateway-api).

To get updated information on this invoice, make a get call with the id returned:

    invoice = client.get_public_invoice(DGrAEmbsXe9bavBPMJ8kuk)'

The BitPay CLI gem requires the BitPay SDK gem. See the [BitPay SDK Gem](https://github.com/bitpay/ruby-client/blob/master/GUIDE.md) documentation for more details on using the BitPay Client SDK.

## Testnet Usage

In order to pair with testnet, you will need a pairing code from test.bitpay.com and will need to use the bitpay client with the --test option.

## API Documentation

API Documentation is available on the [BitPay site](https://bitpay.com/api).

## Running the Tests

    $ bundle install
    $ bundle exec rake
jj
## Found a bug?
Let us know! Send a pull request or a patch. Questions? Ask! We're here to help. We will respond to all filed issues.

## Contributors
[Click here](https://github.com/bitpay/ruby-client/graphs/contributors) to see a list of the contributors to this library.
