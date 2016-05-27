require "#{Rails.root}/lib/shippingwrapper.rb"
class ShippingsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    #render json: variable.as_json(excet: [:created_at, :updated_at])
  # end
  end

  def info
    # binding.pry
    data_packages = params[:shipping][:products_specs]
    data_destination = params[:shipping][:destination]
    data_origin = params[:shipping][:origin]


    total_result = ShippingWrapper.create(data_origin, data_destination, data_packages)
    if total_result.fedex.nil?
      #creates a new log of the BAD requests
      log(params,total_result)
      render json: [], status: :no_content
    else
      #creates a new log of the successful requests
      log(params, total_result)
      render json: total_result.as_json, status: :ok
    end
  end

  def log(params, total_result)
    new_entry = Log.new
    new_entry.received = params.as_json
    new_entry.response = total_result.as_json
    new_entry.save
  end
end
