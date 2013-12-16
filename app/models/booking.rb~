class Booking < ActiveRecord::Base

 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	belongs_to :user
	belongs_to :car
end
