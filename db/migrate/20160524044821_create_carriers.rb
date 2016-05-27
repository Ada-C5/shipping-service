class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name, null: false
      t.string :request, null: false
      t.string :response, null: false
      
      t.timestamps null: false
    end
  end
end
