class ShippingController < ApplicationController
skip_before_filter  :verify_authenticity_token
  def rates
    packages = []
    dest_country = "US"
    dest_state = params[:order][:state]
    dest_city = params[:order][:city]
    dest_zip= params[:order][:zip]

    origin_country = "US"
    origin_state = params[:order][:origin][:state]
    origin_city = params[:order][:origin][:city]
    origin_zip= params[:order][:origin][:zip]

    origin = ActiveShipping::Location.new(country: "US",
           state: origin_state,
           city: origin_city,
           zip: origin_zip)

    destination = ActiveShipping::Location.new(country: 'US',
          state: dest_state,
          city: dest_city,
          zip: dest_zip)

    orderitems = params[:order][:orderitems]

    orderitems.each do |item|
      if item[:quantity] > 1
      item[:quantity] -= 1
      a = item.clone
      orderitems.push a
      end
    end

    orderitems.each do |item|
      weight = item[:weight].to_i
      height = item[:height].to_i
      length = item[:length].to_i
      width = item[:width].to_i
      pack = ActiveShipping::Package.new( weight * 16,          # 7.5 lbs, times 16 oz/lb.
                              [height, length, width],     # 15x10x4.5 inches
                              units: :imperial)  #\
      packages << pack
    end
    ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_KEY'])
    ups_response = ups.find_rates(origin, destination, packages)
    ups_rates = ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    usps_response = usps.find_rates(origin, destination, packages)
    usps_rates = usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    render json: [ups_rates, usps_rates].as_json


  end

end
