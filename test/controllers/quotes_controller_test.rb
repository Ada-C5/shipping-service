require 'test_helper'


module QuotesControllerTest
  class ShowAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      get :show, carrier: "FedEx", shipping: {
            carrier: "FedEx",
            address: { country: "US", state: "WA", city: "Seattle", zip: "98122" }
          }.to_json

      @body = JSON.parse(response.body)
    end

    test "can get #show" do
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

      get :show, carrier: "USPS", shipping: {
            carrier: "USPS",
            address: { country: "", state: "", city: "", zip: "98001" }
          }.to_json

      @body_bad_country = JSON.parse(response.body)
      #
      # get :show, carrier: "USPS", shipping: {
      #       carrier: "USPS",
      #       address: { country: "US", state: nil, city: "Seattle", zip: "98074" }
      #     }.to_json
      #
      # @body_nil = JSON.parse(response.body)
      #
      # get :show, carrier: "USPS", shipping: {
      #       carrier: "USPS",
      #       address: { country: "US", state: "WA", city: "Seattle", zip: "9BCDE" }
      #     }.to_json
      #
      # @body_letter_zip = JSON.parse(response.body)
      #
      # get :show, carrier: "USPS", shipping: {
      #       carrier: "USPS",
      #       address: { country: "US", state: nil, city: "", zip: "980" }
      #     }.to_json
      #
      # @body_incomplete_zip = JSON.parse(response.body)
    end

    test "will raise an error if one of the values in address hash is empty" do

    end

  end




end
