class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :received, null: false
      t.string :response, null: false
      t.timestamps null: false
    end
  end
end
