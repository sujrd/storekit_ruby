# storekit_ruby

[![Code Climate](https://codeclimate.com/github/sujrd/storekit_ruby/badges/gpa.svg)](https://codeclimate.com/github/sujrd/storekit_ruby)
[![Gem Version](http://img.shields.io/gem/v/storekit.svg)](https://rubygems.org/gems/storekit)

This is a no frills gem for verifying Apple App Store In App Purchase receipts.

## Installation

  $ gem install storekit

## Usage

```ruby
require 'storekit'

data = "<Base64-Encoded Receipt Data>"

client = StoreKit::FallbackClient.new
client.shared_secret = "really secret string"
begin
  receipt = client.verify! data

  # The raw data
  p receipt.receipt_data

  # Just the IAP receipts
  p receipt.iap_receipts

  # Hash, mapping from original TX IDs to array of transactions sorted in
  # ascending order by purchase date.
  p receipt.receipt_chains
rescue StoreKit::ValidationError => e
  # ¯\_(ツ)_/¯
  raise 'no soup for you!'
end
```

## License

The gem is available under the MIT license. See the LICENSE file for more info.
