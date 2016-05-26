require 'active_shipping'
require_relative '../models/post_log.rb'

class ShippingController < ApplicationController
  USPS = ActiveShipping::USPS.new(login: ENV['USPS_USERNAME'])
  UPS = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])


  def index
    render json: ["hello world"]
  end

  def search
    origin_params = params["origin_info"]
    destination_params = params["destination_info"]
    weight = params["package_info"]["weight"].to_i
    dimensions = [params["package_info"]["height"].to_i, params["package_info"]["width"].to_i, params["package_info"]["length"].to_i]

    @packages = ActiveShipping::Package.new(weight * 16, dimensions, units: :imperial)
    @origin = ActiveShipping::Location.new(origin_params)
    @destination = ActiveShipping::Location.new(destination_params)

    usps_response = USPS.find_rates(@origin, @destination, @packages)
    ups_response = UPS.find_rates(@origin, @destination, @packages)

    usps_hash = usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    ups_hash = ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    response = [usps_hash, ups_hash]

    log_request_response(params, response)
    # put competing rates in array? -- hash? to send back as json
    # save post response to db
    render json: response
  end

  def log_request_response(request, response)
    PostLog.create(post_request: request, post_response: response)
  end

    # puts ups_response
    # ups_rates = ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    # puts usps_response.rates
    # ups_rates = usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    # puts ups_rates

  # use suggestions_controller from tunes-takeout as inspiration
  # these methods should take in json from betsy and query ups/usps via wrappers then return info to betsy
end
