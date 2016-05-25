class QuotesController < ApplicationController

  def index

    @package = ActiveShipping::Package.new(params[:product][:weight],[params[:product][:width], params[:product][:height]])

    @origin = ActiveShipping::Location.new(params[:origin][:street_address],params[:origin][:city],params[:origin][:state],params[:origin][:zip])

    @destination = ActiveShipping::Location.new(params[:destination][:street_address],params[:destination][:city],params[:destination][:state],params[:destination][:zip])
  end
#data base code

end
