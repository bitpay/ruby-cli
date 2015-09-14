require 'spec_helper'

def tokens
    {"data" => 
      [{"merchant" => "MERCHANTTOKEN"},
      {"pos" =>"POSTOKEN"},
      {"merchant/invoice" => "9kv7gGqZLoQ2fxbKEgfgndLoxwjp5na6VtGSH3sN7buX"}
      ]
    }
end

describe BitPay::Client do
  let(:bitpay_client) { BitPay::Client.new({api_uri: BitPay::TEST_API_URI}) }
  let(:claim_code) { "a12bc3d" }

  before do
      stub_request(:get, /#{BitPay::TEST_API_URI}\/tokens.*/).to_return(:status => 200, :body => tokens.to_json, :headers => {})
  end

  describe "#pair_pos_client" do
    before do
      stub_const('ENV', {'BITPAY_PEM' => PEM})
    end

    it 'throws a BitPayError with the error message if the token setting fails' do
      stub_request(:any, /#{BitPay::TEST_API_URI}.*/).to_return(status: 500, body: "{\n  \"error\": \"Unable to create token\"\n}")
      expect { bitpay_client.pair_pos_client(claim_code) }.to raise_error(BitPay::BitPayError, '500: Unable to create token')
    end 

    it 'gracefully handles 4xx errors' do
      stub_request(:any, /#{BitPay::TEST_API_URI}.*/).to_return(status: 403, body: "{\n  \"error\": \"this is a 403 error\"\n}")
      expect { bitpay_client.pair_pos_client(claim_code) }.to raise_error(BitPay::BitPayError, '403: this is a 403 error')
    end

    it 'short circuits on invalid pairing codes' do
      100.times do
        claim_code = an_illegal_claim_code
        expect{bitpay_client.pair_pos_client(claim_code)}.to raise_error BitPay::ArgumentError, "pairing code is not legal"
      end
    end
  end

end
