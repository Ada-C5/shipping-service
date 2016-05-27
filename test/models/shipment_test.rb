require 'test_helper'

class ShipmentTest < ActiveSupport::TestCase
  test "gets ups rates" do
    shipment = Shipment.ups_rates(
    {weight: 10, height: 20, length: 30, width: 40},
    {country: 'US', city: 'Overland Park', state: 'KS', zip: '66212'},
    {country: 'US', city: 'Seattle', state: 'WA', zip: '98102'}
    )
     assert_instance_of Array, shipment 
   end
  # test "requires a name" do
  #   generic_pet = Pet.new
  #   refute generic_pet.valid?
  #   assert_includes generic_pet.errors.keys, :name
  # end

  # test "requires a pet's name to be unique per human" do
  #   # hint: Read about uniqueness 'scope'
  #   # http://guides.rubyonrails.org/active_record_validations.html#uniqueness
  #   # assert pets(:rosa).valid?

  #   also_rosa = pets(:rosa).dup
  #   refute also_rosa.valid?
  #   assert_includes also_rosa.errors.keys, :name

  #   also_rosa.human = "Not Jeremy"
  #   assert also_rosa.valid?
  # end
end
