require 'active_shipping'
require 'zip-codes'
require 'shipping'

class ShippingController < ApplicationController
  def quotes
    fedex = ShippingWrapper.fedex(params[:zipcode], params[:quantity])
    usps = ShippingWrapper.usps(params[:zipcode], params[:quantity])
    order_id = params[:order_id]
    join = {fedex: fedex, usps: usps}
    render json: join
    Log.create(betsy_json_query: (@_request), betsy_json_response: @_response, betsy_order_id: order_id)
  end
end
