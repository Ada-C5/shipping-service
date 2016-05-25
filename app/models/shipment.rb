class Shipment < ActiveRecord::Base

  def self.ups_rates(product_info, user_info, customer_info)
    packages = ActiveShipping::Package.new(product_info[:weight],[product_info[:height],product_info[:width],product_info[:length]])
    origin = ActiveShipping::Location.new(country: 'US', user_info[:state], user_info[:city], user_info[:zip])
    destination = ActiveShipping::Location.new(country: 'US', customer_info[:state], customer_info[:city], customer_info[:zip])

    ups = ActiveShipping::UPS.new(login: ENV["UPS_USER"], password: ["UPS_PASSWORD"], key: ["ACCESS_KEY"])
    response = ups.find_rates(origin, destination, packages)
    @ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    return @ups_rates
  end

  def self.fedex_rates(product_info, user_info, customer_info)
    packages = ActiveShipping::Package.new(product_info[:weight],[product_info[:height],product_info[:width],product_info[:length]])
    origin = ActiveShipping::Location.new(country: 'US', user_info[:state], user_info[:city], user_info[:zip])
    destination = ActiveShipping::Location.new(country: 'US', customer_info[:state], customer_info[:city], customer_info[:zip])

    fedex = ActiveShipping::FedEx.new(login: ENV["TEST_METER_NUMBER"], password: ENV["TEST_PASSWORD"], key: ENV["DEVELOPER_TEST_KEY"], account: ENV["TEST_ACCOUNT_NUMBER"])
    response = fedex.find_rates(origin, destination, packages)
    @fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    return @fed_rates
  end

end
