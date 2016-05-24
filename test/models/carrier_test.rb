require 'test_helper'

class CarrierTest < ActiveSupport::TestCase
 
  test "returns array" do
    shipping_est = Carrier.estimate_shipping(4, 98126)
    assert_instance_of Array, shipping_est
  end

  
end
