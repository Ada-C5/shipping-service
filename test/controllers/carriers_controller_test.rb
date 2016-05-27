require 'test_helper'

 module CarriersControllerTest
  class CalculateAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      @params = {
        items: 3, state: "WA", city: "Seattle", zip: "98104"
      }
      get :calculate, @params, :format => 'json'
    end

    test "can get #calculate" do
      assert_response :success
    end

    test "#calculate returns json" do
      assert_match 'application/json', response.header['Content-Type']
    end

  end

  class SelectedAction < ActionController::TestCase
    setup do
      # setting up request headers so it knows we want JSON in return
      # not completely necessary, but if you were going to grow your app or API,
      # this could be important
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      post :selected, {'params':
        {carrier_type: "UPS",
        carrier_price: "2222"}}
      # post :search, pet: { name: "rosa" }
      @body1 = JSON.parse(response.body)
    end

    test "can get #select" do
      # :success corresponds with common HTTP response codes. Anything in 200 is success
      assert_response :success
    end

    test "#select returns json" do
      assert_match 'application/json', response.header['Content-Type']
    end
  end


  class ResponseError < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      get :calculate
    end

    test "cannot get #calculate with bad request" do
      assert_response :bad_request
    end
  end

 end
