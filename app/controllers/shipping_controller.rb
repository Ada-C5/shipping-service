require 'active_shipping'
require 'zip-codes'
require 'shipping'

class ShippingController < ApplicationController
  def quotes
    fedex = ShippingWrapper.fedex(params[:zipcode], params[:quantity])
    usps = ShippingWrapper.usps(params[:zipcode], params[:quantity])
    join = {fedex: fedex, usps: usps}
    # fun = {zipcode: params[:zipcode], quantity: params[:quantity]} #this is for the view test
    render json: join
  end

  def usps
    usps = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN"])

    origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
    destination = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', postal_code: '98113')
    packages = ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)

    response = usps.find_rates(origin, destination, packages)
    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    usps_array = []
    usps_rates.each do |service_name, rate_price|
      usps_hash = {}
      usps_hash["usps_service_name"] = service_name
      usps_hash["usps_rate_price"] = rate_price
      usps_array << usps_hash
    end
    render json: usps_array
  end

  def fedex
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"], test: true)
    origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
    destination = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98113')
    packages = ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)

    response = fedex.find_rates(origin, destination, packages)

    fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    fedex_array = []
    fedex_rates.each do |service_name, rate_price|
      fedex_hash = {}
      fedex_hash["service_name"] = service_name
      fedex_hash["rate_price"] = rate_price
      fedex_array << fedex_hash
    end
    render json: fedex_array
  end
end
