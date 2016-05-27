require 'test_helper'

class CarrierTest < ActiveSupport::TestCase

  test "returns usps array" do #methods return Array, API returns hash filled w/Arr
    shipping_est = Carrier.estimate_usps_shipping(4, "WA", "Seattle", "98126")
    assert_instance_of Array, shipping_est
  end

  test "returns ups array" do #methods return Array, API returns hash filled w/Arr
    shipping_est = Carrier.estimate_ups_shipping(4, "WA", "Seattle", "98126")
    assert_instance_of Array, shipping_est
  end


  test "rate for usps returned is not empty" do
    # @carrier = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    origin = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98161')
    usps_rates = Carrier.estimate_usps_shipping("4", "WA", "Seattle", "98116")
   
    refute usps_rates.empty?
  end

  test "rate for ups returned is not empty" do
    # @carrier = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'])
    origin = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98161')
    ups_rates = Carrier.estimate_ups_shipping("4", "WA", "Seattle", "98116")
   
    refute ups_rates.empty?
  end
end
