require 'active_shipping'

module ShippingWrapper
  def self.login_ups
    ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_KEY'])
  end

  def self.login_fedex
    ActiveShipping::UPS.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: ENV['FEDEX_TEST'])
  end
end
