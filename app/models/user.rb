class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
 #   attr_accessible :email, :password, :password_confirmation

    has_many :bookings, dependent: :destroy
    has_many :cars , through: :bookings

    validates :email, uniqueness: true, on: :create
    
    
       
end
