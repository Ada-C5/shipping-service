class QuotesController < ApplicationController

  def index
    quotes = []

    render json: quotes
  end

  def show
    carrier = "some carrier"
    quote = Quote.get_rate(carrier)
    render json: quotes.as_json(except: response)
  end

  def selection

  end

end
