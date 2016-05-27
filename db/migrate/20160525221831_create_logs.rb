class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :request_from_betsy
      t.string :response_to_betsy
      t.timestamps null: false
    end
  end
end
