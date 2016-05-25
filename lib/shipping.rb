require 'zip-codes'

module ShippingWrapper #< ActiveRecord::Base
  def self.fedex(zipcode, quantity)
    location = ZipCodes.identify(zipcode)

    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"], test: true)
    origin = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98103')
    destination = ActiveShipping::Location.new(country: 'US', state: location[:state_code], city: location[:city], zip: zipcode)
    packages = ActiveShipping::Package.new(quantity.to_i * 4, [15, 10, 4.5], units: :imperial)

    response = fedex.find_rates(origin, destination, packages)

    fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    fedex_array = []
    fedex_rates.each do |service_name, rate_price|
      fedex_hash = {}
      fedex_hash["service_name"] = service_name
      fedex_hash["rate_price"] = rate_price
      fedex_array << fedex_hash
    end
    return fedex_array
  end

  def self.usps(zipcode, quantity)
    location = ZipCodes.identify(zipcode)

    usps = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN"])

    origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
    destination = ActiveShipping::Location.new(country: 'US', state: location[:state_code], city: location[:city], zip: zipcode)
    packages = ActiveShipping::Package.new(quantity.to_i * 4, [15, 10, 4.5], units: :imperial)

    response = usps.find_rates(origin, destination, packages)
    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    usps_array = []
    usps_rates.each do |service_name, rate_price|
      usps_hash = {}
      usps_hash["service_name"] = service_name
      usps_hash["rate_price"] = rate_price
      usps_array << usps_hash
    end
    return usps_array
  end
end
