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


  def setup
    @carrier = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
  end

  test "rate returned is not empty" do
    response = @carrier.find_rates(
      ActiveShipping::Location.new(:zip => 98104),
      ActiveShipping::Location.new(:zip => 98126),
      ActiveShipping::Package.new(16, [12, 6, 2], :units => :imperial)
    )

    assert response.success?, response.message
    refute response.rates.empty?
  end
end
