class CarriersController < ApplicationController
skip_before_filter  :verify_authenticity_token

 def index
   ups         = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_ACCESS_KEY'])
   ups_rates   = get_rates(ups)

   usps        = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'], test_mode: true)
   usps_rates  = get_rates(usps)

   fedex       = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_ACCESS_KEY"], account:ENV["FEDEX_ACCOUNT"], test: true )
   fedex_rates = get_rates(fedex)

   request     = [ups, usps].as_json 
   response    = [ups_rates, usps_rates].as_json

   Carrier.create.by(request, response)
   
   if response.status.to_i.between?(200,299)
     render json: response.as_json, status: response.status
   else
     render json: [], message: ":( An Error Has Occured, Please Try Again Later :(", status: response.status
   end
 end

 private

 def get_rates(carrier) 
   packages = []

   destination_country = "US" 
   destination_state   = params[:order][:state].upcase
   destination_city    = params[:order][:city]
   destination_zip     = params[:order][:zip]

   origin_country      = "US"
   origin_state        = params[:origin][:state].upcase
   origin_city         = params[:origin][:city]
   origin_zip          = params[:origin][:zip]

   origin      = ActiveShipping::Location.new(country: "US", state: origin_state, city: origin_city, zip: origin_zip)
   destination = ActiveShipping::Location.new(country: 'US', state: destination_state, city: destination_city, zip: destination_zip)
   order_items = params[:order][:order_items]

   order_items.each do |item|
     weight    = item[:weight].to_i
     length    = item[:length].to_i
     width     = item[:width].to_i
     height    = item[:height].to_i
     packing   = ActiveShipping::Package.new( weight * 16,[length, width, height], units: :imperial )
     packages  << packing
   end

   carrier_response  = carrier.find_rates(origin, destination, packages)
   carrier_rates     = carrier_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]} 
 end
end 