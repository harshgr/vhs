class Car < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable	

	  
	has_many :bookings ,dependent: :destroy
	has_many :users, through: :bookings
end
