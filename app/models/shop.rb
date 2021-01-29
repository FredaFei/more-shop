class Shop < ApplicationRecord
  mount_uploader :logo, ShopLogoUploader
  validates :logo, presence: true
end

