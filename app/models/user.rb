class User < ApplicationRecord
  has_secure_password
  validates_presence_of :phone
  validates_uniqueness_of :phone
  validates_presence_of :password_confirmation, on: [:create]
  validates_format_of :phone, with: /1\d{10}/, if: Proc.new { |u| u.phone.present? }
  validates :password, length: {minimum: 6}, on: [:create], if: :password
end
