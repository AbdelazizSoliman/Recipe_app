# spec/features/recipes_generate_shopping_list_spec.rb
require 'rails_helper'

RSpec.feature 'Recipe Generate Shopping List Page', type: :feature do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe) }

  before do
    sign_in user
  end

  scenario 'generates a shopping list' do
    visit generate_shopping_list_recipe_path(recipe)

    expect(page).to have_content('Shopping List')
    # Add more assertions based on your view template
  end
end
