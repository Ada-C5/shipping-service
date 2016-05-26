require 'active_shipping'

before_filter :indicate_source

def indicate_source
  @api = true
end

class Shipping

  def self.find(origin, destination, packages)
    ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])
    response = ups.find_rates(origin, destination, packages)
    response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end

end

def shipping_rates
  # get the shipping rate from shipping.rb rate method
  # using the params(orgin, destination and package weight info)
  orgins = params[:orgin]
  destination = params[:destination]
  order = params[:order]


  # send the response to method that will calculate rate
    # rates = shipping_rate_calculator(orgin, destination, weight)
    shipping_rates_values = shipping_rates_calculator(orgin, desination, weight)

    response = {shipping_rates_values: shipping_rates_values, order: order, }
  # create a log of incoming request from user
    log = Log.create(request: params.to_s, response: shipping_rate.to_s)

    if shipping_rates_values
      render json: shipping_rates_values.as_json
    else
      render json: [], status: :no_content
    end
end
end
