require 'active_shipping'
require 'zip-codes'
require 'shipping'

class ShippingController < ApplicationController
  def quotes
    fedex = ShippingWrapper.fedex(params[:zipcode], params[:quantity])
    usps = ShippingWrapper.usps(params[:zipcode], params[:quantity])
    join = {fedex: fedex, usps: usps}
    raise
    # Log.create add new and saves it to the database
    # fun = {zipcode: params[:zipcode], quantity: params[:quantity]} #this is for the view test
    render json: join
  end
end
 # Generate new model, called log.rb?  this would then be the database
 # where we keep each log.  Whenever quotes made, create
