class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
	t.string  :title	
	t.integer  :no_of_seates
	t.string  :image
	t.integer  :milage	
	t.string  :registration_no
	
	
	t.timestamps
    end
  end
end
