class Booking < ActiveRecord::Base

  scope :by_car, ->(id) { where(:car_id => id) }

  belongs_to :user
  belongs_to :car

  validates :user, presence: true
  validates :car,  presence: true
  
  

end
