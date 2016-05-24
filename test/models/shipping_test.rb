require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  describe "API" do

    it "should return an instance of USPS", :vcr do
      usps  = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN_KEY"])
      assert usps.is_a? ActiveShipping::USPS
    end

    it "shuld return an instance of Fedex", :vcr do
      fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_METER_NUMBER'],
      password: ENV['FEDEX_TEST_PASSWORD'], key: ENV['FEDEX_TEST_KEY'], account: ENV['FEDEX_ACCOUNT_NUMBER'])
      assert fedex.is_a? ActiveShipping::FedEx
    end

  end
end
