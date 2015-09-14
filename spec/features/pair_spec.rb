require_relative '../spec_helper.rb'

describe "pairing a token", javascript: true, type: :feature do
  let(:claimCode) do 
    File.delete(BitPay::TOKEN_FILE_PATH) if File.exists?(BitPay::TOKEN_FILE_PATH)
    client = BitPay::Client.new(api_uri: ROOT_ADDRESS, insecure: true)
    token = client.get(path: "tokens")["data"].select{|tuple| tuple["merchant"]}.first.values.first
    client.post(path: "tokens", token: token, params: {facade: "pos"})["data"][0]["pairingCode"]
  end

  context "when a pem file exists" do
    before do
      sleep(5)
      `./bin/bitpay pair #{claimCode} --insecure #{ROOT_ADDRESS}`
    end

    it "should save a pem file when pairing" do
      expect(File.exists?(BitPay::PRIVATE_KEY_PATH)).to eq true
    end

    it "should save a token when pairing" do
      expect(JSON.parse(File.read(BitPay::TOKEN_FILE_PATH))["pos"]).to_not be_nil
    end
  end
end
