require 'rails_helper'
require 'rspec_api_documentation/dsl'
resource "Users" do
  let(:user) { create :user }
  post "/users" do
    parameter :phone, '手机号码', type: :string, required: true
    parameter :password, '密码', type: :string, required: true
    parameter :password_confirmation, '确认密码', type: :string, required: true
    example "创建用户（注册）" do
      do_request(phone: user.phone, password: user.password, password_confirmation: user.password_confirmation)
      expect(status).to eq 200
    end
  end
end