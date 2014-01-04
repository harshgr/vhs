class Car < ActiveRecord::Base
  has_many :bookings ,dependent: :destroy
  has_many :users, through: :bookings
  
  mount_uploader :image, ImageUploader
end
