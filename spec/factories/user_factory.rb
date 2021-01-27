FactoryBot.define do
  factory :user do
    phone { "1#{SecureRandom.random_number}" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end