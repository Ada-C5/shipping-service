class CarriersController < ApplicationController
  def calculate
    zip = params[:zip]
    city = params[:city]
    state = params[:state]
    items = params[:items]
    # usps = Carrier.estimate_usps_shipping(items, state, city, zip)
    # ups = Carrier.estimate_ups_shipping(items, state, city, zip)
    # usps.save
    # ups.save
    
    # log = "#{city}, #{state}, #{zip}, #{items}, #{estimate}"
    # log = Carrier.new(request: log)
    # if log.save
    #   @message = "saved!"
    # else
    #   @message = "Save, dammit"
    # end

    estimate = Carrier.estimate_usps_shipping(request)
    parsed_estimate = JSON.parse(estimate.response)
    if estimate.status.to_i.between?(200,299)
      render json: parsed_estimate.to_json, status: estimate.status
    else
      render json: [], message: "Error Message", status: estimate.status
    end
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
