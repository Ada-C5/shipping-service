require 'test_helper'

class CarriersControllerTest < ActionController::TestCase
  setup do
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
    @params = {
      order: { city: "Phoenix", state: "AZ", zip: "85026" },
      origin: { city: "Seattle", state: "WA", zip: "98115" },
      orderitems: [{ height: 4, width: 6, length: 10, weight: 30}]
    }
  end 

  test "response from API should be an array of arrays" do
    post :rates, @params, :format => 'json'
    @body = JSON.parse(response.body)
    puts @body
    assert @body.class, Array
  end 
end
