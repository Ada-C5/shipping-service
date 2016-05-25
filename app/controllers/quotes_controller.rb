class QuotesController < ApplicationController

  def index
    quotes = []

    render json: quotes
  end

  def show
    request = params["shipping"]
    #
      # "shipping": {
      # "carrier": "USPS",
      # "address": { country: "US", state: "WA", city: "Seattle", zip: "98122" }
      # }
      #
    quote = Quote.get_rate(request)
    render json: quote.as_json(only: "response")
  end

  def selection

  end

end
