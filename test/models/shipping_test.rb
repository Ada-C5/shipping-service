require 'test_helper'
require 'pry'

class ShippingTest < ActiveSupport::TestCase

    # @origin = {country: 'US', city: "oakland", state: "CA", zip: '94619'}
    # @destination =  {country: 'US', state: 'NY', city: 'New York City', zip: '10022'}
    #
    #
    # describe "shipping rates" do
    #   it "should return an rates if given a destination and origin and package size" do
    #     ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])
    #     origin = ActiveShipping::Location.new(@origin)
    #     destination = ActiveShipping::Location.new(@destination)
    #     package = ActiveShipping::Package.new(20* 16, [2, 2, 2])
    #
    #     response = @ups.find_rates(origin, destination, package)
    #     result = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    #
    #     shipping_rates = Shipping.find(origin, destination, packages)
    #     assert_match Hash, origin.class
    #   end
    # end

end


  # find rates, should return a collection of objects
