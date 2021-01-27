FactoryBot.define do
  factory :user do
    phone { "12345678999" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end