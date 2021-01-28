require 'rails_helper'
RSpec.describe Session, type: :model do
  it '创建时必须有phone' do
    session = Session.new password: '123456'
    session.validate
    expect(session.errors.details[:phone][0][:error]).to eq :blank
  end
  it '创建时phone为空，则只提示手机号不能为空' do
    session = Session.new password: '123456'
    session.validate
    expect(session.errors.details[:phone][0][:error]).to eq :blank
    expect(session.errors.details[:phone][0].length).to eq 1
  end
  it '创建时phone格式不正确' do
    session = Session.new phone: 'aaa121214', password: '123456'
    session.validate
    expect(session.errors.details[:phone][0][:error]).to eq :invalid
  end
  it '创建时phone格式不正确，password为空。则只提升手机号码格式不正确' do
    session = Session.new phone: 'aaa121214'
    session.validate
    expect(session.errors.details[:phone][0][:error]).to eq :invalid
    expect(session.errors.messages[:phone].length).to eq 1
  end
  it '创建时password为空' do
    session = Session.new phone: '12312312311'
    session.validate
    expect(session.errors.details[:password][0][:error]).to eq :blank
  end
  it '创建时password长度小于6' do
    session = Session.new phone: '12312312311', password: '123'
    session.validate
    expect(session.errors.details[:password][0][:error]).to eq :too_short
  end
  it '创建时手机号码未注册' do
    session = Session.new phone: '10000000000', password: '123123'
    session.validate
    expect(session.errors.details[:phone][0][:error]).to eq :not_found
  end
  it '创建时手机号码与密码不匹配' do
    user = User.create! phone: '12312312311', password: '123123', password_confirmation: '123123'
    session = Session.new phone: user[:phone], password: '000000'
    session.validate
    expect(session.errors.details[:password][0][:error]).to eq :mismatch
  end
end
