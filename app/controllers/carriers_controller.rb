class CarriersController < ApplicationController
  after_action :log

  def calculate
    zip = params[:zip]
    city = params[:city]
    state = params[:state]
    items = params[:items]
    begin
        usps = Carrier.estimate_usps_shipping(items, state, city, zip)
        ups = Carrier.estimate_ups_shipping(items, state, city, zip)
        estimate = {
          "usps" => usps,
          "ups" => ups
        }
        render json: estimate.as_json, :status => :ok
    rescue ActiveShipping::ResponseError
        render json: [], :status => :bad_request
    end

  end

  def selected
    carrier = params[:carrier_type]
    price = params[:carrier_price]
    number = rand(99999) + price.to_i
    tracking = {"#{carrier}" => "#{number}"}
    render json: tracking.as_json, :status => :ok
  end

  def log
    @response = response.body
    @request = {
    zip: params[:zip],
    city: params[:city],
    state: params[:state],
    items: params[:items]}
    Carrier.create(response: @response, request: @request)
  end

end
