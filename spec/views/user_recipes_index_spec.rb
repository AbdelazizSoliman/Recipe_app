require_relative '../rails_helper'

RSpec.describe 'Recipe', type: :system do
  # Create some test users and their associated data
  before do
    @user1 = User.create!(name: 'Peter Dumbari', email: 'mm@recipapp.com', password: '123456')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    @recipe1 = @user1.recipes.create!(name: 'recipe 1', description: 'recipe 1 description', cooking_time: 10,
                                      preparation_time: 5)

    food = @user1.foods.create!(name: 'food 1', measurement_unit: 'kg', price: 10, quantity: 5)
    RecipeFood.create!(quantity: 5, food:, recipe: @recipe1)
  end

  it 'displays recipe information on the User recipe index page' do
    visit recipes_path

    expect(page).to have_content('recipe 1')
    expect(page).to have_content('recipe 1 description')
  end

  it 'redirects to recipe show page when clicking on Details' do
    visit recipes_path
    find("a[id='#{@recipe1.id}']").click

    sleep(5)
    current_path
    expect(current_path).to eq(recipe_path(@recipe1.id))
  end

  it 'redirects to recipes index page when clicking on REMOVE' do
    visit recipes_path
    click_link('REMOVE')

    sleep(5)
    current_path
    expect(current_path).to eq(recipes_path)
  end
end
