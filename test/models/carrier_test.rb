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


  test "rate returned is not empty" do
    @carrier = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    origin = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98161')
    usps_rates = Carrier.estimate_usps_shipping("4", "WA", "Seattle", "98116")
   
    assert usps_rates.success?, usps_rates.message
    refute usps_rates.rates.empty?
  end
end
