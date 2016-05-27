class Shipping


  def initialize(packages,origin,destination)
    @packages = packages
    @origin = origin
    @destination = destination
    @usps = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN_KEY"])
    @fedex = ActiveShipping::FedEx.new(login: ENV['FEDEX_METER_NUMBER'],
    password: ENV['FEDEX_TEST_PASSWORD'], key: ENV['FEDEX_TEST_KEY'], account: ENV['FEDEX_ACCOUNT_NUMBER'], test: true)
  end

  def self.create_by_params(params)


    # getting the actual JSON we want from that big ugly params hash
    package_info = params[:request] # this is a string
    params = JSON.parse(package_info)

    # change zip code to integer because of numeric data error... is this actually needed?
    params["origin"]["zip"] = params["origin"]["zip"].to_i
    params["destination"]["zip"] = params["destination"]["zip"].to_i

    packages = params["products"].map do |product|
      ActiveShipping::Package.new(product["weight"], [product["width"], product["height"]])
    end

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
    Shipping.new(packages,origin,destination)
  end


  def find_rates
    [@usps,@fedex].map do |carrier|
      carrier.find_rates(@origin,@destination,@packages).rates.sort_by(&:price).map do |rate|
        {service_name: rate.service_name, price: rate.price, delivery_date: rate.delivery_date} # rate.delivery_date should go here I think
       end
     end.flatten
  end
end
