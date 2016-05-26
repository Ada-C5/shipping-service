class ShippingInfo
  def initialize(params)
    @params = params
  end

  def ups_rates
    ups = ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_KEY'])
    ups_response = ups.find_rates(origin, destination, packages)
    ups_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end

  def usps_rates
    usps = ActiveShipping::USPS.new(login: ENV['USPS_LOGIN'])
    usps_response = usps.find_rates(origin, destination, packages)
    usps_response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
  end

  private

  def origin
    @origin ||= ActiveShipping::Location.new(country: "US",
      state: @params[:order][:origin][:state],
      city: @params[:order][:origin][:city],
      zip: @params[:order][:origin][:zip])
  end

  def destination
    @destination ||= ActiveShipping::Location.new(country: 'US',
      state: @params[:order][:state],
      city: @params[:order][:city],
      zip: @params[:order][:zip])
  end

  def packages
    @packages ||= begin
      orderitems = @params[:order][:orderitems]

      orderitems.each do |item|
        item[:quantity] = item[:quantity].to_i
        if item[:quantity] > 1
        item[:quantity] -= 1
        a = item.clone
        orderitems.push a
        end
      end

      orderitems.map do |item|
        weight = item[:weight].to_i
        height = item[:height].to_i
        length = item[:length].to_i
        width = item[:width].to_i
        ActiveShipping::Package.new( weight * 16,          # 7.5 lbs, times 16 oz/lb.
                                [height, length, width],     # 15x10x4.5 inches
                                units: :imperial)
      end
    end
  end


end
