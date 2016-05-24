class QuotesController < ApplicationController

  def index
    quotes = []

    render json: quotes
  end

  def show
    request = params["shipping"]
    #
    #   "shipping": {
      # "carrier": "USPS",
      # "address": { country: "US", state: "WA", city: "Seattle", zip: "98122" }
      # }
    #
    quote = Quote.get_rate(request)#(carrier, address)

    render json: quote.as_json(only: response)

    # quote.save
    # quote.request = { "carrier" => "test_carrier", "address" => "test_address" }.to_json
  end

  def selection

  end

end
