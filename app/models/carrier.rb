class Carrier < ActiveRecord::Base
  # logging?? 
  def save_data
    carrier          = Carrier.new 
    carrier.name     = #carrier_name
    carrier.request  = # stuff from betsy
    carrier.response = # shipping selection from betsy
    carrier.save # save that nonsese 
  end 

end