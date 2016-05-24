class Quote < ActiveRecord::Base

  def self.get_rate(request)
    parsed_request = JSON.parse(request)
    origin = Quote.origin

    address1 = { #for testing
      country: "US",
      state: "WA",
      city: "Seattle",
      zip: "98122"
    }

    address = parsed_request["address"]
    destination = Quote.destination(address1) #change to address when not testing
    packages = Quote.packages

    carrier = parsed_request["carrier"] #set from request
    usps = ActiveShipping::USPS.new(login: ENV["USPS_USERNAME"], password: ENV["USPS_PASSWORD"])
    usps_quote = usps.find_rates(origin, destination, packages)
    quote = self.new
    quote.request = request
    quote.response = usps_quote.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]} #this returns JSON - w
    quote.save

  end

  def self.origin
    ActiveShipping::Location.new(country: "US", state: "WA", city: "Seattle", zip: "98121")
  end

  def self.destination(address)
    ActiveShipping::Location.new(country: address[:country], state: address[:state], city: address[:city], zip: address[:zip])
  end

  def self.packages
    ActiveShipping::Package.new(7, [15, 10, 4.5], units: :imperial)
  end

end
