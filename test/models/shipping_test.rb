require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  describe "API" do

    it "should return an instance of USPS", :vcr do
      usps  = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN_KEY"])
      assert usps.is_a? ActiveShipping::USPS
    end

  end
end
