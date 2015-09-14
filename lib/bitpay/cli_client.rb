module BitPay
  class Client < BitPay::SDK::Client
    def initialize opts={}
      pem = File.read(PRIVATE_KEY_PATH) if File.exists?(PRIVATE_KEY_PATH)
      pem = BitPay::KeyUtils.generate_pem unless File.exists?(PRIVATE_KEY_PATH)
      pem = opts[:pem] if opts[:pem]
      File.write(PRIVATE_KEY_PATH, pem)
      opts[:pem] = pem
      super opts
    end

    def pair_pos_client claim_code
      response = super
      token = get_token_from_response response
      File.write(TOKEN_FILE_PATH, token)
      return response
    end

    private
    def get_token_from_response response
      ({response[0]["facade"] => response[0]["token"]}).to_json
    end
  end
end
