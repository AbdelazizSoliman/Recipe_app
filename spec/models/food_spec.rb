require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  user = User.new(name: 'John Doe', email: 'local@host', password: '123456', password_confirmation: '123456')
  before { user.save }
  recipe = Recipe.new(user:, name: 'Recipe 1', description: 'Recipe 1 description', cooking_time: 1,
                      preparation_time: 1, public: true)
  food = Food.new(user:, name: 'Food 1', measurement_unit: 'kg', price: 1, quantity: 1)
  before { recipe.save && food.save }

  recipe_food = RecipeFood.new(recipe:, food:, quantity: 1)
  before { recipe_food.save }

  describe 'associations' do
    it 'belongs to recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'validates presence of recipe' do
      recipe_food = RecipeFood.new
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:recipe]).to include('must exist')
    end

    it 'validates presence of food' do
      recipe_food = RecipeFood.new
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:food]).to include('must exist')
    end
  end
end
