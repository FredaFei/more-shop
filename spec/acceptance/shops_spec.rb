require 'rails_helper'
require 'rspec_api_documentation/dsl'
resource "Shops" do
  post "/shops" do
    parameter :phone, '手机号码', type: :string, required: true
    example "创建店铺" do
      @file = fixture_file_upload('spec/support/test_images/cat.jpg', 'image/jpg')
      do_request(logo: @file)
      expect(status).to eq 200
    end
  end
end