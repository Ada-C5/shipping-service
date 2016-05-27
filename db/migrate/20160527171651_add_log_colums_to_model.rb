class AddLogColumsToModel < ActiveRecord::Migration
  def change
  	add_column :carriers, :city, :string
  	add_column :carriers, :state, :string
  	add_column :carriers, :zip, :string
  end
end
