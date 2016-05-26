require 'test_helper'



module ShippingControllerTest
  class IndexAction < ActionController::TestCase
    setup do
      @request.headers['Content-Type'] = Mime::JSON.to_s
      @request.headers['Accept'] = Mime::JSON

      get :index
      @body = JSON.parse(response.body)
    end

    test "index returns 200" do
      get :index
      assert_response :success
    end
  end

  class SearchAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

        @body = {
          "origin_info": {
            "country": "United States",
            "state": "WA",
            "city": "Seattle",
            "zip": "98115"
          },
          "destination_info": {
            "country": "United States",
            "state": "CA",
            "city": "Los Angeles",
            "zip": "90039"
          },
          "package_info": {
            "weight": "5",
            "height": "15",
            "width": "15",
            "length": "15"
          }
        }

      post :search, @body
      @body = JSON.parse(response.body)
    end

    test "body has two elements" do
      assert_equal 2, @body.length
    end

    test "data being sent do API is JSON" do
      assert_match 'application/json', response.header['Content-Type']
    end

    test "body is an array of info arrays" do
      assert_instance_of Array, @body
      assert_equal Array, @body.map(&:class).uniq.first
    end

    # test "package, origin, destination instances of active_shipping objects" do  
    #   assert_equal 4, @body.pa 
    # end
  end
end
