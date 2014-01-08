class AddTransactionNoToBooking < ActiveRecord::Migration
  def change
  add_column :bookings, :transaction_no, :string 
  end
end
