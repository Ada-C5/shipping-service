  require 'active_shipping'

  # returns shipping rates and determines the size of a package given weight
  # uses active shipping to calculate and return rates
  class Shipping

    SMALL = [5, 5, 5]
    MEDIUM = [10, 10, 10]
    LARGE = [20, 20, 20]


    def initializer
      @ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])
    end

    def self.shipping_rates_calculator(origins, destination, weight)

      total_rates = origins.map do |origin_hash|
        origin = {country: origin_hash[:country], state: origin_hash[:state], city: origin_hash[:city], zip: origin_hash[:zip]}
        response = @ups.find_rates(origin, destination, weight.package_size)
        response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
          # response.rates will return an array of values
              # => [["UPS Standard", 3936],
              #      ["UPS Worldwide Expedited", 8682],
              #      ["UPS Saver", 9348],
              #      ["UPS Express", 9702],
              #      ["UPS Worldwide Express Plus", 14502]]
      end

    end

    def self.package_size(weight)
      # determine the size of the package depending on the weight using set box sizes
      if weight < 20
        SMALL
      elsif weight < 40
        MEDIUM
      else
        LARGE
      end
    end

  end
