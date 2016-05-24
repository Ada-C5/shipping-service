class Shipping #< ActiveRecord::Base
  def fedex
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_KEY"], account: ENV["FEDEX_ACCOUNT"], test: true)
    origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
    destination = ActiveShipping::Location.new(country: 'CA',province: 'ON', city: 'Ottawa', postal_code: 'K1P 1J1')
    packages = [ActiveShipping::Package.new(100, [93,10], cylinder: true), ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)]

    response = fedex.find_rates(origin, destination, packages)

    fedex_array = []
    response.rates.length.times do |service_name, rate_price|
      fedex_hash = {}
      fedex_hash[:fedex_service_name] = response.rates[0].service_name
      fedex_hash[:fedex_rate_price] = response.rates[0].price
      fedex_array << fedex_hash
    end
    render json: fedex_array
  end

  def usps
    usps = ActiveShipping::USPS.new(login: ENV["USPS_LOGIN"])

    origin = ActiveShipping::Location.new(country: 'US', state: 'CA', city: 'Beverly Hills', zip: '90210')
    destination = ActiveShipping::Location.new(country: 'CA',province: 'ON', city: 'Ottawa', postal_code: 'K1P 1J1')
    packages = [ActiveShipping::Package.new(100, [93,10], cylinder: true), ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)]

    response = usps.find_rates(origin, destination, packages)

    usps_array = []
    response.rates.length.times do |service_name, rate_price|
      usps_hash = {}
      usps_hash[:usps_service_name] = response.rates[0].service_name
      usps_hash[:usps_rate_price] = response.rates[0].price
      usps_array << usps_hash
    end
    render json: usps_array
  end
end
