class Carrier < ActiveRecord::Base
  validates :request, presence: true
  validates :response, presence: true

  def self.create_by(request, response)
    carrier = Carrier.new
    carrier.request  = request.body.read
    carrier.response = response.body
    if carrier.save
      return carrier 
    end 
  end 
end