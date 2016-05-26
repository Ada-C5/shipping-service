class QuotesController < ApplicationController

  def show
    quotes = []

    render json: quotes
  end

  def index
    request = params["shipping"]
    #
      # "shipping": {
      # "carrier": "USPS",
      # "address": { country: "US", state: "WA", city: "Seattle", zip: "98122" }
      # }
      #
    quote = Quote.get_rates(request)
    if quote.status.to_i.between?(200,299) # method to check good responses
      render json: quote.response.as_json, status: quote.status
    else
      render json: [], message: "Error Message", status: quote.status
    end
  end

  def selection

  end

end
