require 'spec_helper'

describe BitPay::KeyUtils do
  let(:key_utils) {BitPay::KeyUtils}


  describe '.get_local_private_key' do
    it 'should get the key from ~/.bitpay/bitpay.pem if env variable is not set' do
      allow(File).to receive(:read).with(BitPay::PRIVATE_KEY_PATH) {PEM}
      expect(key_utils.get_local_pem_file).to eq(PEM)
    end

  end

  describe '.retrieve_or_generate_pem' do
    it 'should write a new key to ~/.bitpay/bitpay.pem if there is no existing file' do
      file = class_double("File").as_stubbed_const
      fileutils = class_double("FileUtils").as_stubbed_const
      allow(file).to receive(:read).with(BitPay::PRIVATE_KEY_PATH).and_throw(StandardError)
      allow(fileutils).to receive(:mkdir_p).with(BitPay::BITPAY_CREDENTIALS_DIR).and_return(nil)
      expect(file).to receive(:open).with(BitPay::PRIVATE_KEY_PATH, 'w')
      key_utils.retrieve_or_generate_pem
    end
  end

end
