class Log < ActiveRecord::Base

  #should log, in a database, all requests for shipping information (from betsy, in our case) and all composed responses.
  # This can be a single database table that stores the request json from betsy and the response json sent back to betsy, one row per request.

  def self.create_from_request_and_response(request, response)
    # getting just the JSON we want... this could totally be refactored with the similar thing going on in shipping.rb, but we'll get there if we have time!
    request = request[:request]
    response = response.to_json
    log_entry = Log.create(request_from_betsy: request, response_to_betsy: response)
  end


end
