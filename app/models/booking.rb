class Booking < ActiveRecord::Base

  belongs_to :user
  validates :user ,presence: true
  
  
  belongs_to :car
  validates :car,  presence: true 
  
  
end
