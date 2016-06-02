class AddRequestToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :request, :string
    add_column :logs, :response, :string
  end
end
