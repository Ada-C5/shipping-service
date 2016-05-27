require 'test_helper'
require 'shipping'
# class ShippingTest < ActiveSupport::TestCase
#
#
# end

describe ShippingWrapper do
  describe "API" do
    before do
      @fedex = ShippingWrapper.fedex(98027, 8)
      @usps = ShippingWrapper.usps(98103, 3)
    end

    it "knows contents of json hash" do
      assert_equal "fedex", @fedex.keys
    end
  end
end
