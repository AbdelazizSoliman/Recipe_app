class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end
end
