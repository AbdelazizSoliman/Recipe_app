# spec/features/recipes_show_spec.rb
require 'rails_helper'

RSpec.feature 'Recipe Show Page', type: :feature do
  let(:user) { create(:user) } # Assuming you have a User model and FactoryBot set up
  let(:recipe) { create(:recipe) } # Assuming you have a Recipe model and FactoryBot set up

  before do
    sign_in user # Implement your sign-in method based on your authentication system
  end

  scenario 'displays recipe information' do
    visit recipe_path(recipe)

    expect(page).to have_content(recipe.name)
    # Add more assertions based on your view template
  end
end
