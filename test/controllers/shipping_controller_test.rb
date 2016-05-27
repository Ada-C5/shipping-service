require 'test_helper'

module ShippingControllerTest
  # class QuotesAction < ActionController::TestCase
  #   setup do
  #     @request.headers['Accept'] = Mime::JSON
  #     @request.headers['Content-Type'] = Mime::JSON.to_s
  #     get :quotes, zipcode: 98027, quantity: 12
  #   end
  #
  #   test "can get #quotes" do
  #     assert_response :success
  #     # assert_not_nil assigns(order_id)
  #   end
  #
  #   test "#quotes returns json" do
  #     assert_match 'application/json', response.header['Content-Type']
  #   end
  # end

  class QuotesJSONObject < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      get :quotes, zipcode: 98027, quantity: 12
      @body = JSON.parse(response.body)
      # @keys = [betsy_json_query, betsy_json_response, betsy_order_id]
    end

    test "returns an array of quote objects" do
      assert_instance_of Hash, @body
    end

    test "returns hash of 2 quotes" do
      assert_equal 2, @body.count
    end

    # test "has the right keys" do
    #   assert_equal @keys, @body.keys.sort
    # end

    # test "returns an array of quotes objects" do
    #
    #   assert_instance_of Array, @body
    #   assert_equal Hash, @body.map(&:class).uniq.first
    # end
    #
    # test "returns three quotes objects" do
    #   assert_equal 4, @body.length
    # end
    #
    # test "each quotes object contains the relevant keys" do
    #   keys = %w( fedex usps )
    #   assert_equal keys, @body.map(&:keys).flatten.uniq.sort
    # end
  end
end
