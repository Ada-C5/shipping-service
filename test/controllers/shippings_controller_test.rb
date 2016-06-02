require 'test_helper'

class ShippingsControllerTest < ActionController::TestCase
  setup do
    # expecting json and that will be what I get back
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
    # orgin = [] order_item: (country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210', weight: "20"}
    origins = [{order_item: 1, country: 'US', city: "oakland", state: "CA", weight: '20', zip: '94619'}]
    destination =  {country: 'US', state: 'NY', city: 'New York City', zip: '10022'}
    post :shipping_rates, shipping: { origins: origins, destination: destination}
    @body = JSON.parse(response.body)

  end

  test "can post #shipping_rates" do
    assert_response :success #also known as HTTP code 200
  end





  # test "can get #shipping_rates" do
  #   assert_equal Array, @body #also known as HTTP code 200
  # end
#   test "return an hash with specific key values from ups shipping" do
# hash = [["UPS Standard", 3936],
#  ["UPS Worldwide Expedited", 8682],
# ["UPS Saver", 9348],
#  ["UPS Express", 9702],
# ["UPS Worldwide Express Plus", 14502]]
# hash = {}
#     assert_match
#   end



end
