class AddStatusTo < ActiveRecord::Migration
  def change
    add_column :bookings, :status, :string
    end
end
