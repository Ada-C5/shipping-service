require 'test_helper'


module QuotesControllerTest
  class IndexAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      get :index, { "shipping" => {
            "address" => { "country" => "US", "state" => "WA", "city" => "Seattle", "zip" => "98122" }
          }.to_json }

      @body = JSON.parse(response.body)
    end

    test "can get #index" do
      assert_response :success
    end

    test "it should return a Hash object" do
      assert_instance_of Hash, @body
    end
  end

  class InvalidRequest  < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      #body: { shipping: {"address" => address}.to_json }).parsed_response
      #address = { country: @order.country, state:  @order.state, city:  @order.city, zip:  @order.zip }
      get :index, { "shipping" => {
            "address" => { "country" => "", "state" => "WA", "city" => "Seattle", "zip" => "98122" }
          }.to_json }

      @body_bad_country = JSON.parse(response.body)

      get :index, { "shipping" => {
            "address" => { "country" => "US", "state" => "WA", "city" => "Seattle", "zip" => "2werd" }
          }.to_json }

      @body_letter_zip = JSON.parse(response.body)

    end

    test "will respond 422 when country in address hash is empty" do
      assert_response 422
    end

    test "body will be empty if request has address with bad zip" do
      assert_equal @body_letter_zip, []
    end
  end

  class BadResponse < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      get :index, { "shipping" => {
            "address" => { "country" => "US", "state" => "WA", "city" => "Seattle", "zip" => "11111" }
          }.to_json }

      @body = JSON.parse(response.body)
    end

    test "it should respond with 400 code when address is invalid" do
      assert_response 400
    end
  end




end
