# license Copyright 2011-2014 BitPay, Inc., MIT License
# see http://opensource.org/licenses/MIT
# or https://github.com/bitpay/php-bitpay-client/blob/master/LICENSE

require 'uri'
require 'net/https'
require 'json'
require 'openssl'
require 'ecdsa'
require 'securerandom'
require 'digest/sha2'
require 'cgi'

module BitPay
  class KeyUtils
    class << self
      ## Generates a new private key and writes to local FS
      #
      def retrieve_or_generate_pem
        begin
          pem = get_local_pem_file
        rescue
          pem = generate_pem
          write_pem_file pem
        end
        pem
      end

      def write_pem_file pem
        FileUtils.mkdir_p(BITPAY_CREDENTIALS_DIR)
        File.open(PRIVATE_KEY_PATH, 'w') { |file| file.write(pem) }
      end
      ## Gets private key from ENV variable or local FS
      #
      def get_local_pem_file
        File.read(PRIVATE_KEY_PATH) || (raise BitPayError, MISSING_KEY)
      end
    end
  end
end
