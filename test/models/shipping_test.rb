require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  describe "API" do

    # setup do
    #
    # end

    it "should return an instance of USPS", :vcr do
      usps  = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN_KEY"])
      assert usps.is_a? ActiveShipping::USPS
    end

    it "shuld return an instance of Fedex", :vcr do
      fedex = ActiveShipping::FedEx.new(login: '999999999', password: '7777777', key: '1BXXXXXXXXXxrcB', account: '51XXXXX20')
    end

  end
end
