require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  describe "API" do

    before do
      @usps = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN_KEY"])
      @fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_METER_NUMBER'],
      password: ENV['FEDEX_TEST_PASSWORD'], key: ENV['FEDEX_TEST_KEY'], account: ENV['FEDEX_ACCOUNT_NUMBER'], test: true)
      @packages = [
        ActiveShipping::Package.new(100, [93,10], cylinder: true),
        ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)
      ]
      # You live in Beverly Hills, he lives in Ottawa
      @origin = ActiveShipping::Location.new(country: 'US',
      state: 'CA',
      city: 'Beverly Hills',
      zip: '90210')
      @destination = ActiveShipping::Location.new(country: 'US',
      state: 'AK',
      city: 'Little Rock',
      zip: '72201')
    end

    it "should return an instance of USPS", :vcr do
      # usps  = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN_KEY"])
      assert @usps.is_a? ActiveShipping::USPS
    end

    it "should return an instance of Fedex", :vcr do
      assert @fedex.is_a? ActiveShipping::FedEx
    end

    describe "USPS" do

      it "should return an array when finding USPS rates", :vcr do
        response = @usps.find_rates(@origin, @destination, @packages)
        usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
        assert usps_rates.is_a? Array
      end

      describe " FEDEX" do
        it "should be an array ", :vcr do
          response = @fedex.find_rates(@origin, @destination, @packages)
          price = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
          price.is_a? Array
        end

      end

    end

  end
end
