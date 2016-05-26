require "#{Rails.root}/lib/shippingwrapper.rb"
class ShippingsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    #render json: variable.as_json(excet: [:created_at, :updated_at])
  # end
  end

  def info
    data_packages = params[:products_specs]
    data_destination = params[:destination]
    data_origin = params[:origin]

    total_result = ShippingWrapper.create(data_origin, data_destination, data_packages)

    render json: total_result.as_json

  end

end
