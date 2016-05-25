class Shipping < ActiveRecord::Base

  def package_dimension(weight,length,shape)
    package = ActiveShipping::Package.new(weight,length)

  end

  def origin_of_package(country,state,city,zip)
    origin = ActiveShipping::Location.new(country: country, state: state, zip: zip)

  end

  def destination(country,state,city,zip)
    destination =  ActiveShipping::Location.new(country: country,province: state,city: city,postal_code: zip)
  end



  def how_much_will_the_package_be_for_ups
    ups = ActiveShipping::UPS.new(login: 'auntjudy', password: 'secret', key: 'xml-access-key')
    response = ups.find_rates(origin, destination, packages)
  end


end
