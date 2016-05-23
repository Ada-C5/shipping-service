class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.float :cost_per_item
      t.float :base_delivery_cost

      t.timestamps null: false
    end
  end
end
