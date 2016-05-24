class CarriersController < ApplicationController
  def calculate
    zip = params[:zip]
    city = params[:city]
    state = params[:state]
    items = params[:items]
    estimate = {
      "usps" => Carrier.estimate_usps_shipping(items, state, city, zip),
      "ups" => Carrier.estimate_ups_shipping(items, state, city, zip)}
    render json: estimate.as_json, :status => :ok
  end

  def selected
    carrier = params[:name]
    zip = params[:zip]
    items = params[:items]
  end

  def tracking

  end
end
