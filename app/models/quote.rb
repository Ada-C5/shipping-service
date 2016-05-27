class Quote < ActiveRecord::Base

  def self.get_rates(request)
    parsed_request = JSON.parse(request)
    @quote = self.new
    @quote.request = request
    @origin = Quote.get_origin
    @packages = Quote.get_packages
    address = parsed_request["address"]

    if self.check_zip(address).nil?
      return @quote
    end

    @destination = Quote.get_destination(address) #change to address when not testing
    if @destination.nil?
      return @quote
    end

    begin
      carrier_responses = {
         "FedEx" => self.fedex_rates,
         "USPS" => self.usps_rates
      }

      @quote.response = carrier_responses.to_json
      @quote.status = 200
      @quote.save
      @quote

    rescue
      @quote.response = { "Error": "Bad Request" }.to_json
      @quote.status = 400
      @quote.save
      @quote
    end
  end

  def self.get_origin
    ActiveShipping::Location.new(country: "US", state: "WA", city: "Seattle", zip: "98121")
  end

  def self.get_destination(address)
    begin
      address["zip"] = address["zip"].to_s
      ActiveShipping::Location.new(country: address["country"], state: address["state"], city: address["city"], zip: address["zip"])
    rescue
      self.throw_422_error
      return nil
    end
  end

  def self.get_packages
    ActiveShipping::Package.new(7, [15, 10, 4.5], units: :imperial)
  end

  private

  def self.get_rates_from_carrier(carrier)
    response = carrier.find_rates(@origin, @destination, @packages)
    response.rates.sort_by(&:price).collect { |rate| [rate.service_name, rate.price] }
  end

  def self.fedex_rates
    fedex = ActiveShipping::FedEx.new(login: ENV["FEDEX_USERNAME"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_TEST_KEY"], account: ENV["FEDEX_ACCOUNT_NUMBER"], test: true)
    Quote.get_rates_from_carrier(fedex)
  end

  def self.usps_rates
    usps = ActiveShipping::USPS.new(login: ENV["USPS_USERNAME"], password: ENV["USPS_PASSWORD"])
    Quote.get_rates_from_carrier(usps)
  end

  def self.check_zip(address)
    if address["zip"].nil? || address["zip"].empty?
      self.throw_422_error
      return nil
    elsif address["zip"].length != 5 && address["zip"].length != 9
      self.throw_422_error
      return nil
    elsif address["zip"][/^(\d)+$/] != address["zip"]
      self.throw_422_error
      return nil
    end
    return true
  end

  def self.throw_422_error
    @quote.response = { "Error": "Invalid destination address" }.to_json
    @quote.status = 422
    @quote.save
  end
end
