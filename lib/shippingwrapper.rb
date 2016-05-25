require 'active_shipping'

module ShippingWrapper
  def self.create_fedex(origin, destination, packages )
    ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_KEY'])
    origin = ActiveShipping::Location.new(origin)

    destination = ActiveShipping::Location.new(destination)

    packages = packages.map do |product|
      ActiveShipping::Package.new(product[:weight_lbs] * 16, [product[:length_in], product[:height_in], product[:width_in]],units: product[:units])
    end

    ups_info.find_rates(origin, destination, packages )
  end

  def self.create_fedex(origin, destination, packages )
    fedex_info = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: ENV['FEDEX_TEST'])

    origin = ActiveShipping::Location.new(origin)

    destination = ActiveShipping::Location.new(destination)

    packages = packages.map do |product|
      ActiveShipping::Package.new(product[:weight_lbs] * 16, [product[:length_in], product[:height_in], product[:width_in]],units: product[:units])
    end

    fedex_info.find_rates(origin, destination, packages )
  end
end
