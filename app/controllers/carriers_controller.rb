class CarriersController < ApplicationController
  def calculate
    zip = params[:zip]
    city = params[:city]
    state = params[:state]
    items = params[:items] # TO_i??
    estimate = {
      "usps" => Carrier.estimate_usps_shipping(items, state, city, zip),
      "ups" => Carrier.estimate_ups_shipping(items, state, city, zip)}
    # log = "#{city}, #{state}, #{zip}, #{items}, #{estimate}"
    # log = Carrier.new(request: log)
    # if log.save
    #   @message = "saved!"
    # else
    #   @message = "Save, dammit"
    # end
    render json: estimate.as_json, :status => :ok
  end

  def selected
    carrier = params[:carrier_type]
    price = params[:carrier_price]
    number = rand(99999) + price.to_i
    tracking = {"#{carrier}" => "#{number}"}
    # log = "#{price}, #{carrier}, #{tracking}"
    # log = Carrier.new(request: log)
    # if log.save
    #   @message = "saved!"
    # else
    #   @message = "Save, dammit"
    # end
    render json: tracking.as_json, :status => :ok
  end
end
