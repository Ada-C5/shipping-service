require 'test_helper'
module ShippingControllerTest


  class WhatAreWeDoing < ActionController::TestCase

      test  "it accepts valid json" do

        get :valid_json?
        assert valid_json?, true

      end



  end
end
