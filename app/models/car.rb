class Car < ActiveRecord::Base
#devise :validatable

  scope :capacity, ->(no_of_seates) { where(:no_of_seates => no_of_seates) }

  mount_uploader :image, ImageUploader
  
  has_many :bookings ,dependent: :destroy
  has_many :users, through: :bookings

  validates :no_of_seates, :numericality => { :message => " : Please fill the number value", :only_integer => true } 
  validates :cost_per_day, :numericality => { :message => " : Please fill the number value", :only_integer => true }
  validates :milage, :numericality => { :message => ": Please fill the number value", :only_integer => true } 
 
  def self.get_available_car(no_of_seates,pick_up_date,drop_date)
    joins(:bookings).capacity(no_of_seates).where("date(bookings.pick_up_date) BETWEEN ? AND ? OR date(bookings.drop_date) BETWEEN ? AND ? ", pick_up_date, drop_date, pick_up_date ,drop_date)
  end  
end
