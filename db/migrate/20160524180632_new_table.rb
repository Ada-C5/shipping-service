class NewTable < ActiveRecord::Migration
  def change
  	create_table :carriers do |t|
  	t.string :request
    t.timestamps
    end
  end
end
