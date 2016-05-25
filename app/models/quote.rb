class Quote < ActiveRecord::Base

  def self.get_rate(request)
    parsed_request = JSON.parse(request)
    origin = Quote.get_origin

    address = parsed_request["address"]
    destination = Quote.get_destination(address) #change to address when not testing
    packages = Quote.get_packages

    carrier = parsed_request["carrier"].downcase #set from request
    if carrier == "usps"
      usps = ActiveShipping::USPS.new(login: ENV["USPS_USERNAME"], password: ENV["USPS_PASSWORD"])
      carrier_quote = usps.find_rates(origin, destination, packages)
    elsif carrier == "fedex"
      fedex = ActiveShipping::FEDEX.new(login: ENV["FEDEX_USERNAME"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_TEST_KEY"], account: ENV["FEDEX_ACCOUNT_NUMBER"])
      carrier_quote = fedex.find_rates(origin, destination, packages)
    end

    quote = self.new
    quote.request = request
    quote.response = carrier_quote.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]} #this returns JSON - w
    quote.save
    quote
  end

  def self.get_origin
    ActiveShipping::Location.new(country: "US", state: "WA", city: "Seattle", zip: "98121")
  end

  def self.get_destination(address)
    ActiveShipping::Location.new(country: address["country"], state: address["state"], city: address["city"], zip: address["zip"])
  end

  def self.get_packages
    ActiveShipping::Package.new(7, [15, 10, 4.5], units: :imperial)
  end

end
