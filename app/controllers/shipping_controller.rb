class ShippingController < ApplicationController
skip_before_filter  :verify_authenticity_token
# before_action :log_request
after_action :log_response

  def rates
    info = ShippingInfo.new(params)

    render json: [info.ups_rates, info.usps_rates].as_json

    rescue ActiveShipping::ResponseError => e
      render json: { error: e.message } , status: 400
  end

private
  #
  # def log_request
  #   binding.pry
  #   @request = JSON.parse(request.body)
  #   Shipping.create(request: @request)
  # end

  def log_response
    @response = JSON.parse(response.body)
    Shipping.create(response: @response)
  end

end
