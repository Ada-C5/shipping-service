class QuotesController < ApplicationController

  def index
    binding.pry
    rate_quote = Shipping.create_by_params(params)
    rates = rate_quote.find_rates
    render json: rates.to_json
  end
end
