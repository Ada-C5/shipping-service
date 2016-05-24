require 'test_helper'


module QuotesControllerTest
  class ShowAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      get :show, carrier: "USPS", shipping: {
            "carrier": "USPS",
            "address": { country: "US", state: "WA", city: "Seattle", zip: "98122" }
          }.to_json

      # @body = JSON.parse(@response.body)
    end

    test "can get #show" do
      assert_response :success
    end

    # test "it should return a Quote object" do
    #   assert_instance_of JSON, @body
    # end

  end


end
