class RecipesController < ApplicationController
  
    def index
        @recipes = Recipe.includes(:recipe_foods).where(user_id: current_user.id)
    end
    
    def show
        @recipe = Recipe.includes(:recipe_foods).find(params[:id])
        @recipe_foods = @recipe.recipe_foods
    end
end
  