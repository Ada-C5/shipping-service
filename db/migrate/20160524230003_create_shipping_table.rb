class CreateShippingTable < ActiveRecord::Migration
  def change
    create_table :shipping_tables do |t|
      t.string :carrier, null: false
      t.string :origin_country, default: "US", null: false
      t.string :origin_state, null: false
      t.string :origin_city, null: false
      t.string :origin_zip, null: false
      t.string :destination_country, default: "US", null: false
      t.string :destination_state, null: false
      t.string :destination_city, null: false
      t.string :destination_zip, null: false
      t.float :weight, 100.0, null: false
      t.string :dimensions, default: "12, 12, 6", null: false

      t.timestamps null:false
    end
  end
end
