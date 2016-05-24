require 'test_helper'


module ShippingControllerTest
  class IndexAction < ActionController::TestCase
    setup do
      @request.headers['Accept'] = Mime::JSON
      @request.headers['Content-Type'] = Mime::JSON.to_s

      get :index
      @body = JSON.parse(response.body)
    end

    test "index returns 200" do 
      get :index
      assert_response :success 
    end
  end

  # class SearchAction < ActionController::TestCase
  #   setup do
  #     @request.headers['Accept'] = Mime::JSON
  #     @request.headers['Content-Type'] = Mime::JSON.to_s

  #       @body = {
  #         shipping_info: {
  #           country: USA,
  #           state: WA,
  #           city: Seattle,
  #           zip: 98115
  #           },
  #         package_info: {
  #           weight: 2,
  #           height: 15,
  #           width: 15,
  #           units: :imperial
  #           }
  #         }

  #     get :search
  #     @body = JSON.parse(response.body)
  #   end

  #   # test "index returns 200" do 
  #   #   get :index
  #   #   assert_response :success 
  #   # end
  # end



  #   test "returns an array of pet objects" do

  #     assert_instance_of Array, @body
  #     assert_equal Hash, @body.map(&:class).uniq.first
  #   end

  #   test "returns three pet objects" do
  #     assert_equal 5, @body.length
  #   end

  #   test "each pet object contains the relevant keys" do
  #     keys = %w( age human id name )
  #     assert_equal keys, @body.map(&:keys).flatten.uniq.sort
  #   end
  # end

end
