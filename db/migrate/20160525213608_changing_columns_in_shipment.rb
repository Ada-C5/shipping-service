class ChangingColumnsInShipment < ActiveRecord::Migration
  def change
    remove_column :shipments, :carrier
    remove_column :shipments, :rate
    remove_column :shipments, :delivery_date
    add_column :shipments, :input_rates, :string
    add_column :shipments, :output_rates, :string
    add_column :shipments, :input_confirm, :string
    add_column :shipments, :output_confirm, :string
  end
end
