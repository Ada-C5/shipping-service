class ShipmentsController < ApplicationController
  def index
  shipments = Shipment.all
  render json: shipments.as_json(except: [:created_at, :updated_at])
  # render json: []
  #
  end

  def get_rates
    #data = JSON.parse(params[:_json])
    package = params[:package].with_indifferent_access
    user = params[:origin].with_indifferent_access
    customer = params[:destination].with_indifferent_access

    #this method returns an array of arrays for ups and array of arrays for fedex
    @ups_rates = Shipment.ups_rates(package, user, customer)
    # {weight: 10, height: 20, length: 30, width: 40},
    # {country: 'US', city: 'Overland Park', state: 'KS', zip: '66212'},
    # {country: 'US', city: 'Seattle', state: 'WA', zip: '98102'}

    @fedex_rates = Shipment.fedex_rates(package, user, customer)
    # {weight: 10, height: 20, length: 30, width: 40},
    # {country: 'US', city: 'Overland Park', state: 'KS', zip: '66212'},
    # {country: 'US', city: 'Seattle', state: 'WA', zip: '98102'}

    return @fedex_rates, @ups_rates
  end

end
