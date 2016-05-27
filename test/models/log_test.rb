require 'test_helper'

class LogTest < ActiveSupport::TestCase
  test "Should not save record without json_request" do
    record = Log.new(betsy_json_response: "stuff", betsy_order_id: "77")
    assert_not record.save, "saved the record without a json_request"
  end

  test "Should not save record without json_response" do
    record = Log.new(betsy_json_query: "stuff", betsy_order_id: "77")
    assert_not record.save, "saved the record without a json_response"
  end

  test "Should not save record without order_id" do
    record = Log.new(betsy_json_response: "stuff", betsy_json_query: "more stuff")
    assert_not record.save, "saved the record without a order_id"
  end

end
