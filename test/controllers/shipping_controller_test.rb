require 'test_helper'

class ShippingControllerTest < ActionController::TestCase
  setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      @params = {
        order: { city: "Seattle", state: "WA", country: "US", zip: "98112",
        origin: { state: "WA", zip: '98112', city: "Seattle" },
        orderitems: [{ height: 4, width: 6, length: 10, weight: 30}]
        }
      }

    end

    test "response should be an array" do
      post :rates, @params, :format => 'json'
        @body = JSON.parse(response.body)

        puts @body
      assert @body.class, Array
    end

end
