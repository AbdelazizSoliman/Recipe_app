# /spec/models/recipe_spec.rb
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { Recipe.new } # Define a recipe object

  it 'is valid with valid attributes' do
    recipe.valid? # Validate the recipe without saving it
    expect(recipe).to be_valid
  end

  it 'is not valid without a name' do
    recipe.name = nil
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:name]).to include("can't be blank")
  end

  it 'is not valid with a name less than 3 characters' do
    recipe.name = 'ab'
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:name]).to include('is too short (minimum is 3 characters)')
  end

  it 'is not valid with a name more than 50 characters' do
    recipe.name = 'a' * 51
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:name]).to include('is too long (maximum is 50 characters)')
  end

  it 'is valid with a name between 3 and 50 characters' do
    recipe.name = 'a' * 10
    recipe.valid?
    expect(recipe).to be_valid
  end

  it 'is not valid without a description' do
    recipe.description = nil
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:description]).to include("can't be blank")
  end

  it 'is not valid with a description less than 10 characters' do
    recipe.description = 'a' * 9
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:description]).to include('is too short (minimum is 10 characters)')
  end

  it 'is not valid with a description more than 500 characters' do
    recipe.description = 'a' * 501
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:description]).to include('is too long (maximum is 500 characters)')
  end

  it 'is valid with a description less than 500 characters' do
    recipe.description = 'a' * 10
    recipe.valid?
    expect(recipe).to be_valid
  end

  it 'is not valid without a cooking time' do
    recipe.cooking_time = nil
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:cooking_time]).to include("can't be blank")
  end

  it 'is not valid with a cooking time less than 1' do
    recipe.cooking_time = 0
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:cooking_time]).to include('must be greater than 0')
  end

  it 'is valid with a cooking time greater than 0' do
    recipe.cooking_time = 1
    recipe.valid?
    expect(recipe).to be_valid
  end

  it 'is not valid without a preparation time' do
    recipe.preparation_time = nil
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:preparation_time]).to include("can't be blank")
  end

  it 'is not valid with a preparation time less than 1' do
    recipe.preparation_time = 0
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:preparation_time]).to include('must be greater than 0')
  end

  it 'is valid with a preparation time greater than 0' do
    recipe.preparation_time = 1
    recipe.valid?
    expect(recipe).to be_valid
  end

  it 'is not valid without a public' do
    recipe.public = nil
    recipe.valid?
    expect(recipe).not_to be_valid
    expect(recipe.errors[:public]).to include('is not included in the list')
  end

  it 'is valid with a public boolean value' do
    recipe.public = true
    recipe.valid?
    expect(recipe).to be_valid
    recipe.public = false
    recipe.valid?
    expect(recipe).to be_valid
  end
end
