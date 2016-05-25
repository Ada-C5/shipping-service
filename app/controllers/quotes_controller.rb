class QuotesController < ApplicationController

  def index
    JSON.parse


    @packages = [
        ActiveShipping::Package.new(params[:something][:height], [93,10], cylinder: true),
        ActiveShipping::Package.new(7.5 * 16, [15, 10, 4.5], units: :imperial)
        ]
  end
end
