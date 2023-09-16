require_relative '../rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create!(name: 'Peter Dumbari', email: 'mm@recipapp.com', password: '123456') }
  let(:recipe) do
    user.recipes.create!(name: 'recipe 1', description: 'recipe description', cooking_time: 10, preparation_time: 5)
  end

  describe 'validation' do
    it 'requires name to be present' do
      recipe.name = nil
      expect(recipe).not_to be_valid
    end

    it 'requires description to be present' do
      recipe.description = nil
      expect(recipe).not_to be_valid
    end

    it 'requires cooking_time to be positive number' do
      recipe.cooking_time = -1
      expect(recipe).not_to be_valid
    end

    it 'requires preparation_time to be positive number' do
      recipe.preparation_time = -1
      expect(recipe).not_to be_valid
    end
  end
end
