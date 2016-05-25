class PostLog < ActiveRecord::Base

  def log_request_response(request, response)
    PostLog.create(post_request: request, post_response: response)
  end
end
