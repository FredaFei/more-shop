require 'rails_helper'
RSpec.describe User, type: :model do
  it '创建时必须有phone' do
    # user = create :user, phone: ''
    user = User.create phone: '', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:phone][0][:error]).to eq :blank
  end
  it '创建后密码加密处理' do
    user = User.create phone: '12345678999', password: '123456', password_confirmation: '123456'
    expect(user.password_digest).to_not eq '123456'
    expect(user.id).to be_a Numeric
  end
  it '创建时phone为空，则只提示手机号码不能为空' do
    user = User.create phone: '', password: '123456', password_confirmation: '123456'
    # p user.errors
    expect(user.errors.details[:phone][0][:error]).to eq :blank
    expect(user.errors.details[:phone][0].length).to eq 1
  end
  it '创建时密码为空，则只提示密码不能为空' do
    user = User.create phone: '12345678999', password: '', password_confirmation: '123456'
    expect(user.errors.details[:password][0][:error]).to eq :blank
    expect(user.errors.details[:password][0].length).to eq 1
  end
  it '创建时密码最小长度为6' do
    user = User.create phone: '12345678999', password: '123', password_confirmation: '123456'
    expect(user.errors.details[:password][0][:error]).to eq :too_short
    expect(user.errors.details[:password][0].length).to eq 2
    expect(user.errors.details[:password][0][:count]).to eq 6
  end
  it '创建时确认密码与密码不匹配' do
    user = User.create phone: '12345678999', password: '123123', password_confirmation: '123456'
    expect(user.errors.details[:password_confirmation][0][:error]).to eq :confirmation
    expect(user.errors.details[:password_confirmation][0][:attribute]).to eq 'Password'
    expect(user.errors.details[:password_confirmation][0].length).to eq 2
  end
  it '创建时phone必须唯一' do
    User.create! phone: '12345678999', password: '123456', password_confirmation: '123456'
    user = User.create phone: '12345678999', password: '123456', password_confirmation: '123456'
    expect(user.errors.details[:phone][0][:error]).to eq :taken
  end
end
