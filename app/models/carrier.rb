class Carrier < ActiveRecord::Base
  validates :name, presence: true
  validates :request, presence: true
  validates :response, presence: true

  # logging?? 
  def save_data
    carrier          = Carrier.new 
    carrier.name     = # who the request came from (hipsterly)
    carrier.request  = # stuff from betsy
    carrier.response = # shipping selection from betsy
    carrier.save # save that nonsese 
  end 

end