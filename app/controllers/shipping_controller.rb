require 'active_shipping'

class ShippingController < ApplicationController
  USPS = ActiveShipping::USPS.new(login: ENV['USPS_USERNAME'])
  UPS = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])


  def index
    render json: ["hello world"]
  end

  def search
    # save post request to db
    origin_params = params["origin_info"]
    destination_params = params["destination_info"]
    weight = params["package_info"]["weight"].to_i
    dimensions = [params["package_info"]["height"].to_i, params["package_info"]["width"].to_i, params["package_info"]["length"].to_i]

    @packages = ActiveShipping::Package.new(weight * 16, dimensions, units: :imperial)
    @origin = ActiveShipping::Location.new(origin_params)
    @destination = ActiveShipping::Location.new(destination_params)

    usps_response = USPS.find_rates(@origin, @destination, @packages)
    ups_response = UPS.find_rates(@origin, @destination, @packages)


    # put competing rates in array? -- hash? to send back as json
    # save post response to db
    render json: []
  end

    # puts ups_response
    # ups_rates = ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    # puts usps_response.rates
    # ups_rates = usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    # puts ups_rates

  # use suggestions_controller from tunes-takeout as inspiration
  # these methods should take in json from betsy and query ups/usps via wrappers then return info to betsy 
 #  packages = [
 #  ActiveShipping::Package.new(100,               # 100 grams
 #                              [93,10],           # 93 cm long, 10 cm diameter
 #                              cylinder: true),   # cylinders have different volume calculations

 #  ActiveShipping::Package.new(7.5 * 16,          # 7.5 lbs, times 16 oz/lb.
 #                              [15, 10, 4.5],     # 15x10x4.5 inches
 #                              units: :imperial)  # not grams, not centimetres
 # ]

 # # You live in Beverly Hills, he lives in Ottawa
 # origin = ActiveShipping::Location.new(country: 'US',
 #                                       state: 'CA',
 #                                       city: 'Beverly Hills',
 #                                       zip: '90210')

 # destination = ActiveShipping::Location.new(country: 'CA',
 #                                            province: 'ON',
 #                                            city: 'Ottawa',
 #                                            postal_code: 'K1P 1J1')


end
