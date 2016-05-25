require 'test_helper'
require 'pry'

class ShippingTest < ActiveSupport::TestCase
    describe "shipping rates" do
      it "should return an array of arrays", :vcr do
        ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])
        shipping_rates = Shipping.find(origin, destination, packages)
        assert_kind_of Array, shipping_rates
      end
    end



end


  # find rates, should return a collection of objects
