class ShippingController < ApplicationController

  def search
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
      weight = item[:weight]
      height = item[:height]
      length = item[:length]
      width = item[:width]
      pack = ActiveShipping::Package.new( weight* 16,          # 7.5 lbs, times 16 oz/lb.
                              [height, length, width],     # 15x10x4.5 inches
                              units: :imperial)  #\
      packages << pack
    end
    ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_KEY'])
    response = ups.find_rates(origin, destination, packages)

    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    render json: [ups_rates]
  end

end
