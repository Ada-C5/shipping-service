class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :order_id
      t.string :carrier
      t.decimal :rate
      t.string :delivery_date

      t.timestamps null: false
    end
  end
end
