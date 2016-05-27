require 'test_helper'

module ShippingControllerTest
  class QuotesAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      get :quotes
    end

    test "can get #quotes" do
      assert_response :success
      # assert_not_nil assigns(:log)
    end

    test "#quotes returns json" do
      assert_match 'application/json', response.header['Content-Type']
    end
  end
end

  # class QuotesJSONObject < ActionController::TestCase
  #   setup do
  #     @request.headers['Accept'] = Mime::JSON
  #     @request.headers['Content-Type'] = Mime::JSON.to_s
  #
  #     get :index
  #     @body = JSON.parse(response.body)
  #   end
  #
  #   test "returns an array of quotes objects" do
  #
  #     assert_instance_of Array, @body
  #     assert_equal Hash, @body.map(&:class).uniq.first
  #   end
  #
  #   test "returns three quotes objects" do
  #     assert_equal 4, @body.length
  #   end
  #
  #   test "each quotes object contains the relevant keys" do
  #     keys = %w( fedex usps )
  #     assert_equal keys, @body.map(&:keys).flatten.uniq.sort
  #   end
  # end
