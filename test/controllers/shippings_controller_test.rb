require 'test_helper'
require 'json'

module ShippingsControllerTest
  class ShippingsControllerTest < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s
      #  body: { "products_specs" => products, "destination" => place, "origin" => origin }.to_json,
      # headers: { "Content-Type" => "application/json" }).parsed_response
      products = [{:weight_lbs=>7, :length_in=>10, :height_in=>10, :width_in=>10, :units=>"imperial", :quantity=>1, :item_id=>12}]
      origin = {:country=>"US", :state=>"WA", :city=>"Seattle", :zip=>"98161"}
      place = {:country=>"US", :state=>"WA", :city=>"Seattle", :zip=>"98122"}

      post :info, shipping: {"products_specs" => products, "destination" => place, "origin" => origin }
      @body = JSON.parse(response.body)
    end

    test "can get shipping#info " do
      assert_response :ok
    end

    test "returns an instance of ShippingWrapper objects" do
       assert_equal 3, @body.length
    end

    test "the ShippingWrapper object contains the relevant keys" do
      keys = %w( response fedex ups  )
    assert_equal ["fedex", "ups", "response"], @body.keys
    end
  end

  class InvalidControllerTest < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      products = [{:weight_lbs=>7, :length_in=>10, :height_in=>10, :width_in=>10, :units=>"imperial", :quantity=>1, :item_id=>12}]
      origin = {:country=>"US", :state=>"WA", :city=>"Seattle", :zip=>"98161"}
      place = {:country=>"US", :state=>"WA", :city=>"Seattle", :zip=>"00000"}

      post :info, shipping: {"products_specs" => products, "destination" => place, "origin" => origin }

      @body = JSON.parse(response.body)
    end

    test "cannot get shipping#info " do
      assert_response :no_content
    end
  end
end
