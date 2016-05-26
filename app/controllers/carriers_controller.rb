class CarriersController < ApplicationController
  def calculate
    zip = params[:zip]
    city = params[:city]
    state = params[:state]
    items = params[:items]
    estimate = {
      "usps" => Carrier.estimate_usps_shipping(items, state, city, zip),
      "ups" => Carrier.estimate_ups_shipping(items, state, city, zip)}
    log = "#{city}, #{state}, #{zip}, #{items}, #{estimate}"
    Carrier.create(request: log)
    render json: estimate.as_json, :status => :ok
  end

  def selected
    carrier = params[:carrier_type]
    price = params[:carrier_price]
    number = rand(99999) + price.to_i
    tracking = {"#{carrier}" => "#{number}"}
    log = "#{price}, #{carrier}, #{tracking}"
    Carrier.create(request: log)
    render json: tracking.as_json, :status => :ok
  end
end
