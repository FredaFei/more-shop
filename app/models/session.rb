class Session
  include ActiveModel::Model
  attr_accessor :phone, :password, :user
  validates_presence_of :phone
  validates :password, presence: true
  validates_format_of :phone, with: /1\d{10}/, if: Proc.new { |s| s.phone.present? }
  validate :check_phone, if: Proc.new { |s| s.phone.present? and /1\d{10}/.match s.phone }
  validates :password, length: { minimum: 6 }, if: :password
  validate :phone_password_match, if: Proc.new { |s| s.phone.present? and s.password.present? }
  
  def check_phone
    @user ||= User.find_by_phone phone
    if user.nil?
      errors.add :phone, :not_found
    end
  end
  
  def phone_password_match
    @user ||= User.find_by_phone phone
    if user and not user.authenticate(password)
      errors.add :password, :mismatch
    end
  end
end
