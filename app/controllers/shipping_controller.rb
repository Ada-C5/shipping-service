class ShippingController < ApplicationController
skip_before_filter  :verify_authenticity_token
after_action :logger

  def rates
    info = ShippingInfo.new(params)

    render json: [info.ups_rates, info.usps_rates].as_json

    rescue ActiveShipping::ResponseError => e
      render json: { error: e.message } , status: 400
  end

private

  def logger
    @response = JSON.parse(response.body)
    @request = JSON.parse(request.raw_post)
    Shipping.create(response: @response, request: @request)
  end

end
