require 'active_shipping'

class USPS
 usps = ActiveShipping::USPS.new(login: ENV['USPS_USERNAME'])
 # response = usps.find_rates(@origin, @destination, @packages)
end