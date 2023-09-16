require 'rails_helper'

RSpec.describe Food, type: :model do
  before :each do
    @user = User.create(name: 'John Doe')
    @food = Food.new(name: 'potato', measurement_unit: 'kg', price: 12, quantity: 3, user_id: @user.id)
  end

  it 'is valid with valid attributes' do
    expect(@food).to be_valid
  end

  it 'is invalid without a name' do
    food = Food.create(name: nil)
    expect(food).to_not be_valid
    expect(food.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a measurement_unit' do
    food = Food.create(measurement_unit: nil)
    expect(food).to_not be_valid
    expect(food.errors[:measurement_unit]).to include("can't be blank")
  end

  it 'is invalid without a price' do
    food = Food.create(price: nil)
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include("can't be blank")
  end
end
