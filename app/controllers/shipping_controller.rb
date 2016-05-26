class ShippingController < ApplicationController
skip_before_filter  :verify_authenticity_token

  def rates
    info = ShippingInfo.new(params)

    render json: [info.ups_rates, info.usps_rates].as_json

  rescue ActiveShipping::ResponseError => e
    render json: { error: e.message } , status: 400
  end

end
