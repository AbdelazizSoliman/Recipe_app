# Tests for the recipes show page
# /spec/integration/recipes/show_spec.rb

require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :feature do

  it 'displays the recipe' do
    visit recipe_path(@recipe)

    expect(page).to have_content('Recipe 1')
    expect(page).to have_content('Preparation Time: 10 hours')
    expect(page).to have_content('Cooking Time: 10 hours')
    expect(page).to have_content('Steps goes here...')
    expect(page).to have_link('Generate Shopping List')
    expect(page).to have_link('Add ingredient')

    click_on 'Generate Shopping List'
    expect(page).to have_content('Shopping List')
  end
end
