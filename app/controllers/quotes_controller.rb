class QuotesController < ApplicationController

  def show
    quotes = []

    render json: quotes
  end

  def index
    request = params["shipping"]
    # binding.pry
    #
      # "shipping": {
      # "address": { country: "US", state: "WA", city: "Seattle", zip: "98122" }
      # }
      #
    quote = Quote.get_rates(request)
    parsed_quote = JSON.parse(quote.response)
    if quote.status.to_i.between?(200,299) # method to check good responses
      render json: parsed_quote.to_json, status: quote.status
    else
      render json: [], message: "Error Message", status: quote.status
    end
  end

  def selection

  end

end
