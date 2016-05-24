class Carrier < ActiveRecord::Base

  # stuff to care about:
  # we need packages, origin info, destination info and the rate
  
  # get dem instances 
  ups        = create_ups_instance
  fedex      = create_fedex_instance
  
  #get dem quotes, instance variables for easy passing between model and view  
  @ups_rate   = carrier_quotes(ups)
  @fedex_rate = carrier_quotes(fedex)

  private 
  
  def self.create_ups_instance
    ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_ACCESS_KEY'])
  end

  def self.create_fedex_instance
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"],key: ENV["FEDEX_ACCESS_KEY"], account: ENV["FEDEX_ACCOUNT"])
  end

  def carrier_quotes(carrier)
    # this could be a constant 
    origin      = ActiveShipping::Location.new(country: 'US',
                                               state: 'WA',
                                               city: 'Seattle',
                                               zip: '98118')

    # this is pseudocode for what the params may look like when it comes in 
    destination = ActiveShipping::Location.new(country: params[:country],
                                               state: params[:state],
                                               city: params[:city],
                                               zip: params[:zip])

    # could be an array if we have multiple packages. 
    package     = ActiveShipping::Package.new(5 * 16,           # 5 lbs, times 16 oz/lb.
                                             [12, 12, 3],       # 12x12x3 inches, not centimeters
                                             units: :imperial)  # not grams
  
    # contact active_shipping with pieces of info 
    response    = carrier.find_rates(origin, destination, package)

    # sorts by price and type, also .collect gives us access to enumerate over the collection
    sort_rates  = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end 
end
