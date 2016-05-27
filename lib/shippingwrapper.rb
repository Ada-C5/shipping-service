require 'active_shipping'

class ShippingWrapper
  attr_reader :fedex, :ups, :response
  def initialize(fedex=nil, ups=nil, response=false)
    if fedex.present? && ups.present?
      @fedex = fedex
      @ups = ups
      @response = "Successful Request"
     else
      @fedex = fedex
      @ups = ups
      @response = "Invalid Address"
    end
  end


  def self.create(origin, destination, packages )
    ups_info = ActiveShipping::UPS.new(login: ENV['UPS_LOGIN'], password: ENV['UPS_PASSWORD'], key: ENV['UPS_KEY'])
    fedex_info = ActiveShipping::FedEx.new(login: ENV['FEDEX_LOGIN'], password: ENV['FEDEX_PASSWORD'], key: ENV['FEDEX_KEY'], account: ENV['FEDEX_ACCOUNT'], test: ENV['FEDEX_TEST'])

    # binding.pry
    origin = ActiveShipping::Location.new(origin)
    destination = ActiveShipping::Location.new(destination)

    packages = packages.map do |product|
      ActiveShipping::Package.new(product[:weight_lbs].to_i * 16, [product[:length_in].to_i, product[:height_in].to_i, product[:width_in].to_i], units: product[:units].to_i)
    end

    begin
      fedex_data = fedex_info.find_rates(origin, destination, packages)
      fedex_data = fedex_data.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    rescue
      return self.new(nil,nil, nil)
    end

    begin
      ups_data = ups_info.find_rates(origin, destination, packages)
      ups_data = ups_data.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
    rescue
      return self.new(nil,nil, nil)
    end

    return self.new(fedex_data, ups_data)
  end
end
