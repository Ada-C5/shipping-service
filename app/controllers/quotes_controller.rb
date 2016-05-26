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
    # if quote.status == 200 # method to check good responses

      render json: quote.response, status: quote.status
    # elsif quote.status == 400 # method to check bad responses
      # render json: message: "Error Message", status: quote.status
      # render status: 400
    #end
  end

  def selection

  end

end
