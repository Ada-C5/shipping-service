require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
  add_filter "/app/helpers/"

end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
# require "minispec-metadata"
# require 'vcr'
# require 'minitest-vcr'
# require 'webmock/minitest'
require "minitest/reporters"
Minitest::Reporters.use!
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
