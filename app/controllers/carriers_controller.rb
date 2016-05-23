class CarriersController < ApplicationController
  def calculate
    zip = params[:zip]
    items = params[:items]
    options = {
      "owl_delivery" => calculate_usps(zip, items),
      "unicorn_delivery" => calculate_fedex(zip, items),
      "drone_delivery" => calculate_drone(zip, items)
    }
    render json: options.as_json, :status => :ok
  end

  def selected
    carrier = params[:name]
    zip = params[:zip]
    items = params[:items]
  end

  def tracking

  end
end
