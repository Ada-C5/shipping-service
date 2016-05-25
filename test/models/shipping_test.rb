require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  describe "API" do

    # setup do
    #
    # end
    before do
      @packages = ActiveShipping::Package.new(100, [93,10],cylinder: true)
      @origin = ActiveShipping::Location.new(country: 'US',state: 'CA', city: 'Beverly Hills', zip: '90210')
      @destination = ActiveShipping::Location.new(country: 'CA',province: 'ON',city: 'Ottawa',postal_code: 'K1P 1J1')

      @fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_METER_NUMBER'],
      password: ENV['FEDEX_TEST_PASSWORD'], key: ENV['FEDEX_TEST_KEY'], account: ENV['FEDEX_ACCOUNT_NUMBER'],test: true)

    end

    it "return an instance of Fedex", :vcr  do
      assert @fedex.is_a? ActiveShipping::FedEx

    end

    it "should be an array ", :vcr do
      response = @fedex.find_rates(@origin, @destination, @packages)
      price = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
      price.is_a? Array


    end

  end
end
