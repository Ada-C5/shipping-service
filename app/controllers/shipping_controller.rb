require 'active_shipping'

class ShippingController < ApplicationController
  def quotes
    render json: []
  end
end
