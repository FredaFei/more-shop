require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Sessions" do
  let(:user) { create :user }
  post "/sessions" do
    parameter :phone, '手机号码', type: :string, required: true
    parameter :password, '密码', type: :string, required: true
    example "用户登录" do
      do_request phone: user.phone, password: user.password
      expect(status).to eq 200
    end
  end
  delete "/sessions" do
    example "退出登录" do
      do_request
      expect(status).to eq 200
    end
  end
end