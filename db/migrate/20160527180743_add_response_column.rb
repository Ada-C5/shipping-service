class AddResponseColumn < ActiveRecord::Migration
  def change
  	add_column :carriers, :response, :string
  end
end
