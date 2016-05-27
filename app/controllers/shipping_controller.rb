require 'active_shipping'
require 'zip-codes'
require 'shipping'

class ShippingController < ApplicationController
  def index

  end

  def quotes
    if params[:zipcode]
      fedex = ShippingWrapper.fedex(params[:zipcode], params[:quantity])
      usps = ShippingWrapper.usps(params[:zipcode], params[:quantity])
      order_id = params[:order_id]
      join = {fedex: fedex, usps: usps}
      render json: join.as_json(except: [:updated_at])
      Log.create(betsy_json_query: (@_request), betsy_json_response: @_response, betsy_order_id: order_id)
    else
      render json: [], status: :no_content
    end
  end
end
