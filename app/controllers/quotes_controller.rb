class QuotesController < ApplicationController

  def index
    request = params["shipping"]
    quote = Quote.get_rates(request)
    parsed_quote = JSON.parse(quote.response)

    if quote.status.to_i.between?(200,299) # method to check good responses
      render json: parsed_quote.to_json, status: quote.status
    else
      render json: [], message: "Error, check status", status: quote.status
    end
  end

end
