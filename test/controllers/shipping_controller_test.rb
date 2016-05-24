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
    end

    test "#quotes returns json" do
      assert_match 'application/json', response.header['Content-Type']
    end
  end
end
