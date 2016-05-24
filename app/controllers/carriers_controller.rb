class CarriersController < ApplicationController
  def calculate
    zip = params[:zip]
    items = params[:items]
    estimate = {
      "usps" => Carrier.estimate_usps_shipping(5, 98104),
      "ups" => Carrier.estimate_ups_shipping(5, 98104)}
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
