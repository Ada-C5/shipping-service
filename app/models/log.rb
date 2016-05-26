class Log < ActiveRecord::Base
  validates_presence_of :betsy_json_query, :betsy_json_response, :betsy_order_id
end
