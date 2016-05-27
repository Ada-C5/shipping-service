require 'active_shipping'


class Shipment < ActiveRecord::Base

  def initialize(name)
    @name = name
  end


  def self.ups_rates(product_info, user_info, customer_info)
    packages = ActiveShipping::Package.new(product_info[:weight],[product_info[:height],product_info[:width],product_info[:length]])

    origin = ActiveShipping::Location.new({country: 'US'}.merge(user_info))

    destination = ActiveShipping::Location.new({country: 'US'}.merge(customer_info))

    ups = ActiveShipping::UPS.new(login: ENV["UPS_USER"], password: ENV["UPS_PASSWORD"], key: ENV["ACCESS_KEY"])
    response = ups.find_rates(origin, destination, packages)
    @ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
    return @ups_rates
    # [["UPS Ground", 1777, nil],
    #  ["UPS Three-Day Select",
    #   4875,
    #   Tue, 31 May 2016 00:00:00 +0000],
    #  ["UPS Second Day Air",
    #   7310,
    #   Mon, 30 May 2016 00:00:00 +0000],
    #  ["UPS Next Day Air Saver",
    #   11610,
    #   Fri, 27 May 2016 00:00:00 +0000],
    #  ["UPS Next Day Air",
    #   11947,
    #   Fri, 27 May 2016 00:00:00 +0000],
    #  ["UPS Next Day Air Early A.M.",
    #   15029,
    #   Fri, 27 May 2016 00:00:00 +0000]]
  end

  def self.fedex_rates(product_info, user_info, customer_info)
    packages = ActiveShipping::Package.new(product_info[:weight],[product_info[:height],product_info[:width],product_info[:length]])

    origin = ActiveShipping::Location.new({country: 'US'}.merge(user_info))

    destination = ActiveShipping::Location.new({country: 'US'}.merge(customer_info))

    fedex = ActiveShipping::FedEx.new(login: ENV["TEST_METER_NUMBER"], password: ENV["TEST_PASSWORD"], key: ENV["DEVELOPER_TEST_KEY"], account: ENV["TEST_ACCOUNT_NUMBER"], :test => true)
    response = fedex.find_rates(origin, destination, packages)

    @fedex_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
    return @fedex_rates
  end


end
