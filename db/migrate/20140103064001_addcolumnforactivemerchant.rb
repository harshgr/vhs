class Addcolumnforactivemerchant < ActiveRecord::Migration
  def change
     add_column :bookings, :total_cost, :integer
     add_column :cars, :cost_per_day, :integer
  end
end
