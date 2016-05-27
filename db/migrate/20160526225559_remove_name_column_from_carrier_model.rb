class RemoveNameColumnFromCarrierModel < ActiveRecord::Migration
  def change
    remove_column :carriers, :name, :string
  end
end
