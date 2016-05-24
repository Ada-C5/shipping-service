class Carrier < ActiveRecord::Base

  # stuff to care about:
    # we need packages, origin info, destination info and the rate

  

  # Using the ActiveShipping gem: 
  # def self.create_ups_instance
  #   ActiveShipping::UPS.new(login: ENV["UPS_LOGIN"], password: ENV["UPS_PASSWORD"], key: ENV['UPS_ACCESS_KEY'])
  # end

  # def self.create_fedex_instance
  #   ActiveShipping::FEDEX.new(login: ENV["FEDEX_LOGIN"], password: ENV["FEDEX_PASSWORD"], key: ENV["FEDEX_ACCESS_KEY"], account:ENV["FEDEX_ACCOUNT"] )
  # end

end
