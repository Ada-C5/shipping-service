class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :betsy_json_query
      t.string :betsy_json_response
      t.string :betsy_order_id
      t.timestamps null: false
    end
  end
end
