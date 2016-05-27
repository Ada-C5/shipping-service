class AddColumnsToCarrierModel < ActiveRecord::Migration
  def change
    add_column :carriers, :name, :string
    add_column :carriers, :request, :string
    add_column :carriers, :response, :string
  end
end
