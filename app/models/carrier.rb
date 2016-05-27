require 'active_shipping'

class Carrier < ActiveRecord::Base

  ORIGIN = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98161')

  def self.estimate_usps_shipping(items, state, city, zip)

    packages = ActiveShipping::Package.new(items.to_i * 14, [93, 10], cylinder: false)
    destination = ActiveShipping::Location.new(country: 'US', state: state, city: city, zip: zip)

    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    response = usps.find_rates(ORIGIN, destination, packages)

    response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    
  begin
    estimate = {
      "usps" => Carrier.estimate_usps_shipping(items, state, city, zip),
      "ups" => Carrier.estimate_ups_shipping(items, state, city, zip)
    }

      new_estimate = self.new
      new_estimate.request = request
      new_estimate.response = estimate.to_json
      new_estimate.status = 200
      new_estimate.save
      new_estimate

    rescue

      new_estimate = self.new
      new_estimate.request = request
      new_estimate.response = { "Error": "Something went wrong" }.to_json
      new_estimate.status = 400
      new_estimate.save
      new_estimate
    end
  end

  def self.estimate_ups_shipping(items, state, city, zip)
    packages = ActiveShipping::Package.new(items.to_i * 14, [93, 10], cylinder: false)
    destination = ActiveShipping::Location.new(country: 'US', state: state, city: city, zip: zip)

    ups = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_KEY'])

    response = ups.find_rates(ORIGIN, destination, packages)

    response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    self.new
  end

end
