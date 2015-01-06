require_relative '../spec_helper.rb'

describe "pairing a token", javascript: true, type: :feature do
  let(:claimCode) do 
    visit ROOT_ADDRESS
    click_link('Login')
    fill_in 'email', :with => TEST_USER
    fill_in 'password', :with => TEST_PASS
    click_button('loginButton')
    click_link "My Account"
    click_link "API Tokens", match: :first
    find(".token-access-new-button").find(".btn").find(".icon-plus").click
    sleep 0.25
    click_button("Add Token")
    find(".token-claimcode", match: :first).text
  end
  context "when no pem file exists" do
    before do
      File.delete(BitPay::PRIVATE_KEY_PATH) if File.exists?(BitPay::PRIVATE_KEY_PATH)
      File.delete(BitPay::TOKEN_FILE) if File.exists?(BitPay::TOKEN_FILE)
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
