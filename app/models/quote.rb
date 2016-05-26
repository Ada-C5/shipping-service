class Quote < ActiveRecord::Base

  def self.get_rates(request)
    parsed_request = JSON.parse(request)
    @origin = Quote.get_origin
    @packages = Quote.get_packages
    address = parsed_request["address"]
    @destination = Quote.get_destination(address) #change to address when not testing
    begin
      carrier_responses = [
        {
          "fedex" => fedex_rates
        },
        {
         "usps" => usps_rates
        }
      ]
      # binding.pry

      quote = self.new
      quote.request = request
      quote.response = carrier_responses.to_json
      quote.status = 200
      quote.save
      quote

    rescue

      quote = self.new
      quote.request = request
      quote.response = { "Error": "Some error" }.to_json
      quote.status = 400
      quote.save
      quote

    end
  end

  def self.get_origin
    ActiveShipping::Location.new(country: "US", state: "WA", city: "Seattle", zip: "98121")
  end

  def self.get_destination(address)
    ActiveShipping::Location.new(country: address["country"], state: address["state"], city: address["city"], zip: address["zip"])
  end

  def self.get_packages
    ActiveShipping::Package.new(7, [15, 10, 4.5], units: :imperial)
  end

  private

  def get_rates_from_carrier(carrier)
    response = carrier.find_rates(@origin, @destination, @packages)
    response.rates.sort_by(&:price).collect { |rate| [rate.service_name, rate.price] }
  end

  def fedex_rates
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_USERNAME"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_TEST_KEY"], account: ENV["FEDEX_ACCOUNT_NUMBER"], test: true)
    get_rates_from_carrier(fedex)
  end

  def usps_rates
    usps = ActiveShipping::USPS.new(login: ENV["USPS_USERNAME"], password: ENV["USPS_PASSWORD"])
    get_rates_from_carrier(usps)
  end

  def check_country(address)
    if address["country"].nil? || address["country"].empty?
      #error
    elsif address["country"].length != 2 && address["country"].length != 3
      #error
    elsif address["country"][/[a-zA-Z]+/] != address["country"]
      #error
    end
  end

  def check_zip(address)
  end


end
