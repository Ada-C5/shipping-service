class Quote < ActiveRecord::Base

  def self.get_rate(request)
    parsed_request = JSON.parse(request)
    origin = Quote.origin

    address = parsed_request["address"]
    destination = Quote.destination(address) #change to address when not testing
    packages = Quote.packages

    carrier = parsed_request["carrier"].downcase #set from request
    if carrier = "usps"
      usps = ActiveShipping::USPS.new(login: ENV["USPS_USERNAME"], password: ENV["USPS_PASSWORD"])
      carrier_quote = usps.find_rates(origin, destination, packages)
    elsif carrier = "fedex"
      fedex = ActiveShipping::FEDEX.new(login: ENV["FEDEX_USERNAME"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_TEST_KEY"], account: ENV["FEDEX_ACCOUNT_NUMBER"])
      carrier_quote = fedex.find_rates(origin, destination, packages)
    end

    quote = self.new
    quote.request = request
    quote.response = carrier_quote.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]} #this returns JSON - w
    quote.save

  end

  def self.origin
    ActiveShipping::Location.new(country: "US", state: "WA", city: "Seattle", zip: "98121")
  end

  def self.destination(address)
    ActiveShipping::Location.new(country: address["country"], state: address["state"], city: address["city"], zip: address["zip"])
  end

  def self.packages
    ActiveShipping::Package.new(7, [15, 10, 4.5], units: :imperial)
  end

end
