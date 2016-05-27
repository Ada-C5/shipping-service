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
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      post :selected, {'params':
        {carrier_type: "UPS",
        carrier_price: "2222"}}
      @body1 = JSON.parse(response.body)
    end

    test "can get #select" do
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
