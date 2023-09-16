require_relative '../rails_helper'

RSpec.describe 'Recipe', type: :system do
  # Create some test users and their associated data
  before do
    @user1 = User.create!(name: 'Peter Dumbari', email: 'mm@recipapp.com', password: '123456', role: 'admin')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    @recipe1 = @user1.recipes.create!(name: 'recipe 1', description: 'recipe 1 description', cooking_time: 10,
                                      preparation_time: 5)

    food = @user1.foods.create!(name: 'food 1', measurement_unit: 'kg', price: 10, quantity: 5)
    RecipeFood.create!(quantity: 20, food:, recipe: @recipe1)
  end

  it 'displays recipe information on the User recipe show page' do
    visit recipe_path(@recipe1.id)

    expect(page).to have_content('recipe 1')
    expect(page).to have_content('Cooking time: 10.0')
    expect(page).to have_content('Preparation time: 5.0')
    expect(page).to have_content('food 1')
    expect(page).to have_content(20.0)
  end

  it 'redirects to recipe_food add food page when clicking on Add food' do
    visit recipe_path(@recipe1.id)
    click_link('Add Food')

    sleep(5)
    current_path
    expect(current_path).to eq(new_recipe_recipe_food_path(@recipe1.id))
  end

  it 'redirects to recipe show  page when clicking on Remove' do
    visit recipe_path(@recipe1.id)
    click_link('Remove')

    sleep(5)
    current_path
    expect(current_path).to eq(recipe_path(@recipe1.id))
  end

  it 'redirects to recipe show  page when clicking on public checkbox' do
    visit recipe_path(@recipe1.id)
    find('#public-checkbox').set(true)

    sleep(5)
    current_path
    expect(current_path).to eq(recipe_path(@recipe1.id))
  end
end
