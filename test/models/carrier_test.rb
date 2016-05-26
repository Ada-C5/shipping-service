require 'test_helper'

class CarrierTest < ActiveSupport::TestCase

  test "requires a name" do
    carrier = Carrier.new
    refute carrier.valid?
    assert_includes carrier.errors.keys, :name
  end
end
