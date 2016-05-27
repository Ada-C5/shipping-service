class RemoveColumnsAddStatus < ActiveRecord::Migration
  def change
  	remove_column :carriers, :state, :string
  	remove_column :carriers, :city, :string
  	remove_column :carriers, :zip, :string
  	add_column :carriers, :status, :string
  end
end
