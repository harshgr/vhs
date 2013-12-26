class AddConfirmedAt < ActiveRecord::Migration
  def change
    add_column :users, :confirmed_at, :string
  end
end
