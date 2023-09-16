# spec/features/recipes_add_ingredient_spec.rb
require 'rails_helper'

RSpec.feature 'Recipe Add Ingredient Page', type: :feature do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe) }

  before do
    sign_in user
  end

  scenario 'allows adding ingredients' do
    visit add_ingredient_recipe_path(recipe)

    fill_in 'Ingredient Name', with: 'Example Ingredient'
    fill_in 'Quantity', with: '10'
    # Add more form fields if needed

    click_button 'Add Ingredient'

    expect(page).to have_content('Example Ingredient')
    # Add more assertions based on your view template
  end
end
