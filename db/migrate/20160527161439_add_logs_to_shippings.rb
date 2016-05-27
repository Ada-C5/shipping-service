class AddLogsToShippings < ActiveRecord::Migration
  def change
    add_column :shippings, :request, :string
    add_column :shippings, :response, :string
  end
end
