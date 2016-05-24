class ShippingController < ApplicationController
  def quotes
    render json: []
  end

  def fedex
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"])
    
    tracking_info = fedex.find_tracking_info('tracking-number', carrier_code: 'fedex_ground') # Ground package

    tracking_info.shipment_events.each do |event|
      puts "#{event.name} at #{event.location.city}, #{event.location.state} on #{event.time}. #{event.message}"
    end
  end
end
