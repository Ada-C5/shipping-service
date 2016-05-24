require 'active_shipping'

module ShippingWrapper
  def login
    ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: 'UPS_PASSWORD', key: ENV['UPS_KEY'])
  end
end
