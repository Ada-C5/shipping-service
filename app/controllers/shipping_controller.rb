require 'active_shipping'

class ShippingController < ApplicationController
  def quotes
    render json: []
  end

  def usps_1
    render json: []
  end

  def fedex
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"])

    tracking_info = fedex.find_tracking_info('tracking-number', carrier_code: 'fedex_ground') # Ground package

    tracking_info.shipment_events.each do |event|
      puts "#{event.name} at #{event.location.city}, #{event.location.state} on #{event.time}. #{event.message}"
    end
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
