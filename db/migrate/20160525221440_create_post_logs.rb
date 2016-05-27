class CreatePostLogs < ActiveRecord::Migration
  def change
    create_table :post_logs do |t|
      t.string :post_request
      t.string :post_response

      t.timestamps null: false
    end
  end
end
