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

    if total_result.fedex.nil?
      #creates a new log of the BAD requests
      new_entry = Log.new
      new_entry.received = params.as_json
      new_entry.response = total_result.as_json
      new_entry.save

      render json: total_result.as_json(except: [:fedex, :ups]), status: :no_content
    else
      #creates a new log of the successful requests
      new_entry = Log.new
      new_entry.received = params.as_json
      new_entry.response = total_result.as_json
      new_entry.save

      render json: total_result.as_json, status: :ok
    end


  end

end
