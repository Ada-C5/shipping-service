class QuotesController < ApplicationController

  def index
    # adds the request to the log??
    # HTTParty.post(log_path, body: params.to_json)



    rate_quote = Shipping.create_by_params(params)
    rates = rate_quote.find_rates

    ## why does the existence of this line make the render json not work below?
    Log.create_from_request_and_response(params, rates)

    # log_entry = Log.new(params, rates)
    # binding.pry
    # if log_entry.save
    #   puts "YAY you added to the log"
    # else
    #   puts "NO it didn't save"
    # end
    # adds this response to the log??
    # HTTParty.post(log_path, body: rates.to_json)
    render json: rates.to_json
  end
end
