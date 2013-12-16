class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :no_of_seates
      t.string :pick_up_location
      t.time   :pick_up_time
      t.string :drop_location
      t.date   :date_of_booking
      t.integer:no_of_days
      t.integer:price
      
      t.references :user
      t.timestamps
    end
  end
end
