require 'active_shipping'

class ShippingWrapper
  attr_reader :fedex, :ups, :response
  def initialize(fedex=nil, ups=nil, response=false)
    if fedex.present? && ups.present?
      @fedex = fedex.params["RateReply"]['RateReplyDetails']
      @ups = ups.params["RatedShipment"]
    else
      @response = "Invalid Address"
      @fedex = fedex
      @ups = ups
    end
  end


  def self.create(origin, destination, packages )
    ups_info = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_KEY'])
    fedex_info = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: ENV['FEDEX_TEST'])

    # binding.pry

    origin = ActiveShipping::Location.new(origin)
    destination = ActiveShipping::Location.new(destination)

    packages = packages.map do |product|
      ActiveShipping::Package.new(product[:weight_lbs] * 16, [product[:length_in], product[:height_in], product[:width_in]],units: product[:units])
    end

    # binding.pry
    fedex_data = fedex_info.find_rates(origin, destination, packages)
    ups_data = ups_info.find_rates(origin, destination, packages)

    return self.new(fedex_data, ups_data)


  end

end
