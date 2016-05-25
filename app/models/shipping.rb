require 'active_shipping'

class Shipping

  

  def self.find(origin, destination, packages)
    ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])
    response = ups.find_rates(origin, destination, packages)
    response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end

end
