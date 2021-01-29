require 'spec_helper'
# require 'support/fog_helper'
require 'carrierwave/test/matchers'

describe ShopLogoUploader do
  include CarrierWave::Test::Matchers
  # before do
  #   ShopLogoUploader.enable_processing = true
    # @file = fixture_file_upload('spec/support/test_images/cat.jpg', 'image/jpg')
    # @uploader = ShopLogoUploader.new(@file)
    # @uploader.store!(File.open("#{Rails.root}/tmp/uploads/#{Rails.env}/images/"))
  # end
  
  let(:uploader) { ShopLogoUploader.new(fixture_file_upload('spec/support/test_images/cat.jpg', 'image/jpg')) }

  before do
    ShopLogoUploader.enable_processing = true
    File.open('spec/support/test_images/cat.jpg') { |f| uploader.store!(f) }
  end

  after do
    ShopLogoUploader.enable_processing = false
    uploader.remove!
  end

  context 'url' do
    it "image url" do
      p uploader
    end
  end
end