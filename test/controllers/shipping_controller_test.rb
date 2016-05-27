require 'test_helper'

class ShippingControllerTest < ActionController::TestCase
  setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      @params = {
        order: { city: "Seattle", state: "WA", country: "US", zip: "98112",
        origin: { state: "WA", zip: '98112', city: "Seattle" },
        orderitems: [{ height: 4, width: 6, length: 10, weight: 30, quantity: 1}]
        }
      }
    end

    test "response should be an array" do
      post :rates, @params, :format => 'json'
        @body = JSON.parse(response.body)
      assert @body.class, Array
    end

    test "response should handle multiple quantities without breaking" do
      @shippings= {
        order: { city: "Seattle", state: "WA", country: "US", zip: "98112",
        origin: { state: "WA", zip: '98112', city: "Seattle" },
        orderitems: [{ height: 4, width: 6, length: 10, weight: 30, quantity: 4}]
        }
      }
      post :rates, @shippings, :format => 'json'
        @body = JSON.parse(response.body)

      assert_response :success
    end

    test "response should return status 400 given bad info" do
      @bad= {
        order: { city: "Seattle", state: "WA", country: "US", zip: "10309",
        origin: { state: "WA", zip: '98112', city: "Seattle" },
        orderitems: [{ height: 4, width: 6, length: 10, weight: 30, quantity: 4}]
        }
      }
      post :rates, @bad, :format => 'json'
        @body = JSON.parse(response.body)

      assert_response 400
    end



end
