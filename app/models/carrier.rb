class Carrier < ActiveRecord::Base
  # helper_method :calculate_usps
  # helper_method :calculate_fedex 
  # helper_method :calculate_drone #:calculate_all_carriers

  # def calculate_all_carriers(zip, items)
  #
  # end
  def calculate_usps(zip, items)
    base_cost = 4
    distance = (zip - 98104).abs
    standard = base_cost + (items * distance)
    expedited = standard + 2
    overnight = standard * 3
    return [standard, expedited, overnight]
  end

  def calculate_fedex(zip, items)
    base_cost = 5
    distance = (zip - 98104).abs
    standard = base_cost + (items * distance)
    expedited = standard + 2
    overnight = standard * 3
    return [standard, expedited, overnight]
  end

  def calculate_drone(zip, items)
    base_cost = 6
    distance = (zip - 98104).abs
    standard = base_cost + (items * distance)
    expedited = standard + 2
    overnight = standard * 3
    return [standard, expedited, overnight]
  end
end
