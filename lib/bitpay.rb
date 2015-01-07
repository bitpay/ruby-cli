# license Copyright 2011-2014 BitPay, Inc., MIT License
# see http://opensource.org/licenses/MIT
# or https://github.com/bitpay/php-bitpay-client/blob/master/LICENSE

libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)
require 'bitpay_sdk'
require 'bitpay/cli_client'
require 'bitpay/cli_key_utils'
require 'bitpay/version'

module BitPay

  BITPAY_CREDENTIALS_DIR = ENV['RCBITPAYROOT'] || File.expand_path("~") + "/.bitpay/"
  PRIVATE_KEY_FILE = 'bitpay.pem'
  PRIVATE_KEY_PATH = File.join(BITPAY_CREDENTIALS_DIR, PRIVATE_KEY_FILE)
  TOKEN_FILE = 'tokens.json'
  TOKEN_FILE_PATH = File.join(BITPAY_CREDENTIALS_DIR, TOKEN_FILE)

  MISSING_KEY = 'No Private Key specified.  Pass priv_key or set ENV variable PRIV_KEY'
end
