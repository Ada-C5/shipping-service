require 'test_helper'

module ShipmentsControllerTest < ActionController::TestCase
# class IndexAction < ActionController::TestCase
#     setup do
#       @request.headers['Accept'] = Mime::JSON
#       @request.headers['Content-Type'] = Mime::JSON.to_s
#       get :index
#     end

#     test "can get #index" do
#       assert_response :success
#     end

#     test "#index returns json" do
#       assert_match 'application/json', response.header['Content-Type']
#     end
#   end

#   class IndexJSONObject < ActionController::TestCase
#     setup do
#       @request.headers['Accept'] = Mime::JSON
#       @request.headers['Content-Type'] = Mime::JSON.to_s

#       get :index
#       @body = JSON.parse(response.body)
#     end

#     test "returns an array of pet objects" do

#       assert_instance_of Array, @body
#       assert_equal Hash, @body.map(&:class).uniq.first
#     end

#     test "returns three pet objects" do
#       assert_equal 3, @body.length
#     end

#     test "each pet object contains the relevant keys" do
#       keys = %w( age human id name )
#       assert_equal keys, @body.map(&:keys).flatten.uniq.sort
#     end
#   end

#   class ShowAction < ActionController::TestCase
#     setup do
#       @request.headers['Accept'] = Mime::JSON
#       @request.headers['Content-Type'] = Mime::JSON.to_s
#       get :show, id: pets(:rosa).id
#     end

#     test "can get #show" do
#       assert_response :success
#     end

#     test "#show returns json" do
#       assert_match 'application/json', response.header['Content-Type']
#     end
#   end

#   class ShowJSONObject < ActionController::TestCase
#     setup do
#       @request.headers['Accept'] = Mime::JSON
#       @request.headers['Content-Type'] = Mime::JSON.to_s

#       get :show, id: pets(:rosa).id
#       @body = JSON.parse(response.body)
#       @keys = %w( age human id name )
#     end

#     test "has the right keys" do
#       assert_equal @keys, @body.keys.sort
#     end

#     test "has all of Rosa's info" do
#       @keys.each do |key|
#         assert_equal pets(:rosa)[key], @body[key]
#       end
#     end
#   end

#   class NoPetsFound < ActionController::TestCase
#     setup do
#       @request.headers['Accept'] = Mime::JSON
#       @request.headers['Content-Type'] = Mime::JSON.to_s

#       get :show, id: 1000
#       @body = JSON.parse(response.body)
#     end

#     test "no pet found is a 204 (no content)" do
#       assert_response 204
#     end

#     test "no pet found is an empty array" do
#       assert_equal [], @body
#     end
#   end

#   class FuzzyPetSearch < ActionController::TestCase
#     setup do
#       @request.headers['Accept'] = Mime::JSON
#       @request.headers['Content-Type'] = Mime::JSON.to_s

#       post :search, pet: { name: "rosa" }
#       @body = JSON.parse(response.body)
#     end

#     test "can post #search" do
#       assert_response :success
#     end

#     test "#search returns json" do
#       assert_match 'application/json', response.header['Content-Type']
#     end


#     test "search term is not case sensitive" do

#     end

#     test "search term uses fuzzy match" do

#     end
#   end

end
