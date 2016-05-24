require 'active_shipping'

class Carrier

  # def initialize

  # end

  ORIGIN = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98161')

  def self.estimate_usps_shipping(items, state, city, zip)

    packages = ActiveShipping::Package.new(items * 14, [93, 10], cylinder: false)
    ORIGIN
    destination = ActiveShipping::Location.new(country: 'US', state: state, city: city, zip: zip)

    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    response = usps.find_rates(ORIGIN, destination, packages)

    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    # self.new
  end

  def self.estimate_ups_shipping(items, state, city, zip)
    packages = ActiveShipping::Package.new(items * 14, [93, 10], cylinder: false)
    ORIGIN
    destination = ActiveShipping::Location.new(country: 'US', state: state, city: city, zip: zip)

    ups = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_KEY'])

    response = ups.find_rates(ORIGIN, destination, packages)

    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

  end

end
