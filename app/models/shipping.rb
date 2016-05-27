  require 'active_shipping'

  # returns shipping rates and determines the size of a package given weight
  # uses active shipping to calculate and return rates
  class Shipping

    SMALL = [5, 5, 5]
    MEDIUM = [10, 10, 10]
    LARGE = [20, 20, 20]

    # UPS_LOGIN = "rishallen_5"
    # UPS_PASSWORD = "29E8Y5"
    # UPS_KEY = "9D0CA9FE6A4849E8"

    def initializer

      # @ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])
      @ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])

    end

    def self.shipping_rates_calculator(origins, destination)

      destination = active_shipping_location(destination)

      total_rates = origins.map do |origin_hash|

        origin = active_shipping_location(origin_hash["origin"])

        package = active_shipping_package(origin_hash)
        @ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV["UPS_KEY"])

        response = @ups.find_rates(origin, destination, package)
        if response.message == "Success"
           response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
          # response.rates will return an array of values
              # => [["UPS Standard", 3936],
              #      ["UPS Worldwide Expedited", 8682],
              #      ["UPS Saver", 9348],
              #      ["UPS Express", 9702],
              #      ["UPS Worldwide Express Plus", 14502]]
        else
          "Invalid"
        end
      end
      total_rates
    end

    def self.active_shipping_location(location)


      # location = ActiveShipping::Location.new(country: location["country"],  state: location["state"], city: location["city"],  zip: location["zip"])
      location = ActiveShipping::Location.new(country: location["country"],
                                                state: location["state"],
                                                 city: location["city"],
                                                  zip: location["zip"])


    end

    def self.active_shipping_package(package_info)
      package = ActiveShipping::Package.new((package_info["weight"].to_f) * 16,
                                 package_size(package_info["weight"].to_f))
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
