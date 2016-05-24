require 'test_helper'

class CarrierTest < ActiveSupport::TestCase

  test "returns usps array" do
    shipping_est = Carrier.estimate_usps_shipping(4, 98126)
    assert_instance_of Array, shipping_est
  end

  test "returns ups array" do
    shipping_est = Carrier.estimate_ups_shipping(4, 98126)
    assert_instance_of Array, shipping_est
  end


end
