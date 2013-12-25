class AddIsadminToUsers < ActiveRecord::Migration
  def change
        add_column :users, :isadmin, :string
  end
end
