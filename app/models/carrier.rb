require 'active_shipping'

class Carrier

  # def initialize
    
  # end

  ORIGIN = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98161')
  
  def self.estimate_shipping(items, zip)

    packages = ActiveShipping::Package.new(items * 14, [93, 10], cylinder: false)
    ORIGIN
    destination = ActiveShipping::Location.new(country: 'US', state: '', city: '', zip: zip)
    
    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    response = usps.find_rates(ORIGIN, destination, packages).to_json

    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    return usps_rates
    # self.new
  end

end
