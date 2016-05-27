require 'active_shipping'

class Carrier

  ORIGIN = ActiveShipping::Location.new(country: 'US', state: 'WA', city: 'Seattle', zip: '98161')

  def self.estimate_usps_shipping(items, state, city, zip)

    # parsed_request = JSON.parse(request)

    packages = ActiveShipping::Package.new(items.to_i * 14, [93, 10], cylinder: false)
    destination = ActiveShipping::Location.new(country: 'US', state: state, city: city, zip: zip)

    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    response = usps.find_rates(ORIGIN, destination, packages)

    usps_response = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    
    if usps_response.nil?
      return "Didn't work"
    else
      return usps_response
    end
  end

  def self.estimate_ups_shipping(items, state, city, zip)
    packages = ActiveShipping::Package.new(items.to_i * 14, [93, 10], cylinder: false)
    destination = ActiveShipping::Location.new(country: 'US', state: state, city: city, zip: zip)

    ups = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_KEY'])

    response = ups.find_rates(ORIGIN, destination, packages)

    ups_response = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    
     if ups_response.nil?
      return "Didn't work"
    else
      return ups_response
    end
  end

  # def self.get_code
  #   begin
  #   estimate = {
  #     "usps" => Carrier.estimate_usps_shipping(items, state, city, zip),
  #     "ups" => Carrier.estimate_ups_shipping(items, state, city, zip)

  #   }

  #     new_estimate = self.new
  #     new_estimate.request = items, state, city, zip
  #     new_estimate.response = estimate.to_json
  #     new_estimate.status = 200
  #     new_estimate.save
  #     new_estimate

  #   rescue

  #     new_estimate = self.new
  #     new_estimate.request = items, state, city, zip
  #     new_estimate.response = { "Error": "Something went wrong" }.to_json
  #     new_estimate.status = 400
  #     new_estimate.save
  #     new_estimate
  #   end
    
  # end

end
