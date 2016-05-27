require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require "minispec-metadata"
require "minitest/reporters"


class ActiveSupport::TestCase
 fixtures :all
end
