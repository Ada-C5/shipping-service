class QuotesController < ApplicationController

  def index
    quotes = []

    render json: quotes
  end

  def show
    carrier = "USPS"
    address = "(JSONObjectRecieved).address"

    quote = Quote.get_rate(carrier, address)
    render json: quote.as_json(except: request)

    # quote.save
    # quote.request = { "carrier" => "test_carrier", "address" => "test_address" }.to_json
  end

  def selection

  end

end
