class CarriersController < ApplicationController
skip_before_filter  :verify_authenticity_token

  def index
    placeholder = {carrier: "UPS", carrier: "USPS"}
    render json: [placeholder].as_json
  end

  def get_rates
    packages = []

    destination_country = "US"
    destination_state   = params[:order][:state]
    destination_city    = params[:order][:city]
    destination_zip     = params[:order][:zip]

    origin_country      = "US"
    origin_state        = "WA"
    origin_city         = "Seattle"
    origin_zip          = "98115"

    origin      = ActiveShipping::Location.new(country: "US", state: origin_state, city: origin_city, zip: origin_zip)

    destination = ActiveShipping::Location.new(country: 'US', state: destination_state, city: destination_city, zip: destination_zip)

    orderitems  = params[:order][:orderitems]

    orderitems.each do |item|
      weight    = item[:weight].to_i
      height    = item[:height].to_i
      length    = item[:length].to_i
      width     = item[:width].to_i
      packing   = ActiveShipping::Package.new( weight * 16, units: :imperial)
      packages  << packing
    end

    ups             = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_ACCESS_KEY'])
    ups_response    = ups.find_rates(origin, destination, packages)
    ups_rates       = ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}


    usps            = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    usps_response   = usps.find_rates(origin, destination, packages)
    usps_rates      = usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    fedex           = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_ACCESS_KEY"], account:ENV["FEDEX_ACCOUNT"], test: true )
    fedex_response  = fedex.find_rates(origin, destination, packages)
    fedex_rates     = fedex_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}



    render json: [ups_rates, usps_rates, fedex_rates].as_json
  end

  def choose_rates

  end 
end 