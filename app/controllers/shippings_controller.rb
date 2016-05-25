require "#{Rails.root}/lib/shippingwrapper.rb"

class ShippingsController < ApplicationController

  def index
    #render json: variable.as_json(excet: [:created_at, :updated_at])
  # end
  end

  def ups
    @ups_info = ShippingWrapper.login_ups
    @ups_info.find_rates
  end

  def fedex
    @fedex_info = ShippingWrapper.login_fedex
    @fedex_info.find_rates
  end

  def info
    look = params
    render json: [], status: :success
  end
 #
 # origin = ActiveShipping::Location.new(country: 'US',
 #                                       state: 'CA',
 #                                       city: 'Beverly Hills',
 #                                       zip: '90210')
 #
 # destination = ActiveShipping::Location.new(country: 'CA',
 #                                            province: 'ON',
 #                                            city: 'Ottawa',
 #                                            postal_code: 'K1P 1J1')


#shippings
#provider (UPS/FedEx)
#types
#cost
#tracking
#delivery


#This is what we need to save in our API.
#id
#address
#address2
#city
#state
#zipcode
#response
end
