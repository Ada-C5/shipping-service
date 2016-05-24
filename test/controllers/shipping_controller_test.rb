require 'test_helper'

class ShippingControllerTest < ActionController::TestCase
  setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      post :search, order: { city: "Seattle", state: "WA", country: "US", zip: "98112",
           orderitems: { height: 4, width: 6, length: 10, weight: 30} }
      @body = JSON.parse(response.body)
    end

    test "response should be an array" do
      assert @body.class, Array
    end 

end
