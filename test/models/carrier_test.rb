require 'test_helper'

class CarrierTest < ActiveSupport::TestCase

  test "returns usps hash" do #methods return Array, API returns hash filled w/Arr
    shipping_est = Carrier.estimate_usps_shipping(4, "WA", "Seattle", "98126")
    assert_instance_of Array, shipping_est
  end

  test "returns ups hash" do #methods return Array, API returns hash filled w/Arr
    shipping_est = Carrier.estimate_ups_shipping(4, "WA", "Seattle", "98126")
    assert_instance_of Array, shipping_est
  end


end
