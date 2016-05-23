class Carrier < ActiveRecord::Base
  helper_method :calculate_usps
  helper_method :calculate_fedex #:calculate_all_carriers

  # def calculate_all_carriers(zip, items)
  #
  # end
  def calculate_usps(zip, items)
    BASE_COST = 4
    distance = (zip - 98104).abs
    standard = BASE_COST + (items * distance)
    expedited = standard + 2
    overnight = standard * 3
    return [standard, expedited, overnight]
  end

  def calculate_fedex(zip, items)
    BASE_COST = 5
    distance = (zip - 98104).abs
    standard = BASE_COST + (items * distance)
    expedited = standard + 2
    overnight = standard * 3
    return [standard, expedited, overnight]
  end

  def calculate_drone(zip, items)
    BASE_COST = 6
    distance = (zip - 98104).abs
    standard = BASE_COST + (items * distance)
    expedited = standard + 2
    overnight = standard * 3
    return [standard, expedited, overnight]
  end
end
