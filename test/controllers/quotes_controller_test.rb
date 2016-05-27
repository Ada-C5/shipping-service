require 'test_helper'

module QuotesControllerTest
  class IndexAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      @params = {
          origin:
            # default address of Ada (treating it like a central warehouse)
            { street_address: "1215 4th Ave", city: "Seattle", state: "WA", zip: "98161" },
          destination:
            { street_address: "1600 Pennsylvania Ave NW", city: "Washington", state: "DC", zip: "20500" },
          products:
            [  { height: 5, width: 2, weight: 0.3 }, { height: 3, width: 4, weight: 6 }  ]
          }
    end

    test "can get index action" do
      # binding.pry
      post :index, request: @params, :format => 'json'
      @body = JSON.parse(response.body)
      assert_response :success
    end

  end
end
