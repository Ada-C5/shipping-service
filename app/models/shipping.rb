class Shipping < ActiveRecord::Base


  def initialize(package,origin,destination)
    @package = package
    @origin = origin
    @destination = destination
    @usps = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN_KEY"])
    @fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_METER_NUMBER'],
    password: ENV['FEDEX_TEST_PASSWORD'], key: ENV['FEDEX_TEST_KEY'], account: ENV['FEDEX_ACCOUNT_NUMBER'], test: true)
  end

  def self.create_by_params(params)

    package_info = params.keys[0] # this is a string
    params = JSON.parse(package_info)
    params["origin"]["zip"] = params["origin"]["zip"].to_i
    # binding.pry
    params["destination"]["zip"] = params["destination"]["zip"].to_i
    package = ActiveShipping::Package.new(params["product"]["weight"],[params["product"]["width"], params["product"]["height"]])

    # origin = ActiveShipping::Location.new( params["origin"].merge("country" => "US"))
    origin = ActiveShipping::Location.new(
      country: "US",
      state: params["origin"]["state"],
      city: params["origin"]["city"],
      zip: params["origin"]["zip"]
    )
    destination = ActiveShipping::Location.new(
      country: "US",
      state: params["origin"]["state"],
      city: params["origin"]["city"],
      zip: params["origin"]["zip"]
      )
    Shipping.new(package,origin,destination)
  end


  def find_rates
    [@usps,@fedex].map do |carrier|
      # binding.pry
      carrier.find_rates(@origin,@destination,@package).rates.sort_by(&:price).map do |rate|
        {service_name: rate.service_name, price: rate.price}
       end
     end.flatten
  end
end
