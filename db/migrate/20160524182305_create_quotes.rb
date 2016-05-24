class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :request
      t.string :response
      t.string :selection

      t.timestamps null: false
    end
  end
end
