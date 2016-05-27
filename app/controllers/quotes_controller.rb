class QuotesController < ApplicationController

  def index
    # adds the request to the log??
    # HTTParty.post(log_path, body: params.to_json)
    rate_quote = Shipping.create_by_params(params)
    rates = rate_quote.find_rates

    Log.create_from_request_and_response(params, rates)

    render json: rates.to_json
  end
end
