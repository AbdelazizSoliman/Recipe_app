require_relative '../rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create!(name: 'Peter Dumbari', email: 'mm@recipapp.com', password: '123456') }
  let(:recipe) do
    user.recipes.create!(name: 'recipe 1', description: 'recipe description', cooking_time: 10, preparation_time: 5)
  end
  let(:food) { user.foods.create!(name: 'food 1', measurement_unit: 'kg', price: 10, quantity: 5) }
  let(:recipe_food) { RecipeFood.create!(quantity: 5, food:, recipe:) }

  describe 'validation' do
    it 'requires quantity to be present' do
      recipe_food.quantity = nil
      expect(recipe_food).not_to be_valid
    end

    it 'requires quantity to be greater than 0' do
      recipe_food.quantity = -1
      expect(recipe_food).not_to be_valid
    end
  end
end
