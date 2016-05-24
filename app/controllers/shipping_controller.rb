require 'active_shipping'

class ShippingController < ApplicationController
  def quotes
    render json: []
  end

  def fedex
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"], test: true)
    origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
    destination = ActiveShipping::Location.new(country: 'CA',province: 'ON', city: 'Ottawa', postal_code: 'K1P 1J1')
    packages = [ActiveShipping::Package.new(100, [93,10], cylinder: true), ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)]

    fedex_hash = {}

    response = fedex.find_rates(origin, destination, packages)
    raise
    puts "this is the response length #{response.rates.length}"

    fedex_hash[:fedex_service_name] = response.rates[0].service_name
    fedex_hash[:fedex_rate_price] = response.rates[0].price

    fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render json: fedex_hash
  end

  def usps
    usps = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN"])
    origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
    destination = ActiveShipping::Location.new(country: 'CA',province: 'ON', city: 'Ottawa', postal_code: 'K1P 1J1')
    packages = [ActiveShipping::Package.new(100, [93,10], cylinder: true), ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)]

    response = usps.find_rates(origin, destination, packages)

    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    render json: usps_rates.as_json(except: [:created_at, :updated_at])
  end
end
