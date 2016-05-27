class ShipmentsController < ApplicationController
  def index
  shipments = Shipment.all
  render json: shipments.as_json(except: [:created_at, :updated_at])
  # render json: []
  #
  end

  def shipping_rates
    #this method returns an array of arrays for ups and array of arrays for fedex
    @ups_rates = Shipment.ups_rates(
    {weight: 10, height: 20, length: 30, width: 40},
    {country: 'US', city: 'Overland Park', state: 'KS', zip: '66212'},
    {country: 'US', city: 'Seattle', state: 'WA', zip: '98102'}
    )
    # @shipping_rates.each do |shipping_option|
    #   shipping_option[0] #service name
    #   shipping_option[1] #price
    #   shipping_option[2] #delivery date

    @fedex_rates = Shipment.fedex_rates(
    {weight: 10, height: 20, length: 30, width: 40},
    {country: 'US', city: 'Overland Park', state: 'KS', zip: '66212'},
    {country: 'US', city: 'Seattle', state: 'WA', zip: '98102'}
    )
    return @fedex_rates
  end

end
