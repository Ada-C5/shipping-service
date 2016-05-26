require 'active_shipping'
require_relative '../models/post_log.rb'

class ShippingController < ApplicationController
  USPS = ActiveShipping::USPS.new(login: ENV['USPS_USERNAME'])
  UPS = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])

  #Kept for testing purposes.
  def index
    render json: ["hello world"]
  end

  def search
    #Information from Betsy:
    origin_params = params["origin_info"]
    destination_params = params["destination_info"]
    weight = params["package_info"]["weight"].to_i
    dimensions = [params["package_info"]["height"].to_i, params["package_info"]["width"].to_i, params["package_info"]["length"].to_i]

    #New instances of the data ActiveShipping needs:
    @packages = ActiveShipping::Package.new(weight * 16, dimensions, units: :imperial)
    @origin = ActiveShipping::Location.new(origin_params)
    @destination = ActiveShipping::Location.new(destination_params)

    #Send instances along to retrieve rates:
    usps_response = USPS.find_rates(@origin, @destination, @packages)
    ups_response = UPS.find_rates(@origin, @destination, @packages)

    #Returned sorted rates data:
    usps_results_array = usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    usps_results_array = ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    #What we're sending back to betsy:
    response = [usps_hash, ups_hash]

    #Save request/response to database:
    log_request_response(params, response)

    #Render resonse:
    render json: response
  end

  #Method to save logs for audit:
  def log_request_response(request, response)
    PostLog.create(post_request: request, post_response: response)
  end
end
