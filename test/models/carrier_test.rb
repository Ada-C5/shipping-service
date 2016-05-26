require 'test_helper'

class CarrierTest < ActiveSupport::TestCase

  test "requires a request" do
    carrier = Carrier.new
    refute carrier.valid?
    assert_includes carrier.errors.keys, :request
  end

  test "requires a response" do
    carrier = Carrier.new
    refute carrier.valid?
    assert_includes carrier.errors.keys, :response
  end
end
