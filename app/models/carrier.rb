class Carrier < ActiveRecord::Base

    # stuff to care about:
    # we need packages, origin info, destination info and the rate
    
    # get dem instances 
    create_ups_instance
    create_fedex_instance

    # this could be a constant 
    origin = ActiveShipping::Location.new(country: 'US',
                                          state: 'WA',
                                          city: 'Seattle',
                                          zip: '98118')

    destination = ActiveShipping::Location.new(country: params[:country],
                                               state: params[:state],
                                               city: params[:city],
                                               zip: params[:zip])

    # could be an array if we have multiple packages. 
    packages = ActiveShipping::Package.new(5 * 16,          # 7.5 lbs, times 16 oz/lb.
                                 [12, 12, 3],     # 15x10x4.5 inches
                                 units: :imperial)  # not grams, not centimetres
  
    # contact active_shipping with pieces of info 
    get_rates = ups.find_rates(origin, destination, packages)

    # sorts by price and type, also .collect gives us access to enumerate over the collection
    sort_rates = ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    private 
    # Using the ActiveShipping gem: 
    def self.create_ups_instance
      ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_ACCESS_KEY'])
    end

    def self.create_fedex_instance
      fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"],key: ENV["FEDEX_ACCESS_KEY"], account: ENV["FEDEX_ACCOUNT"])
    end

end
