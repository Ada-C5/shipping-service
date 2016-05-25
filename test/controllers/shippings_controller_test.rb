require 'test_helper'

class ShippingsControllerTest < ActionController::TestCase
  setup do
    # expecting json and that will be what I get back
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
    get :index 
  end

  # can i get the index?
  # had to set up an index method in the pets model
  test "can get #index" do
    assert_response :success #also known as HTTP code 200
  end
end
