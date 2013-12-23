class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string   :pick_up_location
      t.time     :pick_up_time
      t.string   :drop_location
      t.date     :pick_up_date
      t.date     :drop_date
    
      
      t.references :user
      t.references :car
      t.timestamps
    end
  end
end
