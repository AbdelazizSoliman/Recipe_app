class RecipesController < ApplicationController
    # before_action :authenticate_user!, except: [:show]
  
    def index
      @recipes = current_user.recipes.includes(:foods)
    end
  
    def new
      @recipe = Recipe.new
    end
  
    def add_ingredient
      @recipe = Recipe.find(params[:id])
  
      if current_user == @recipe.user
        @foods_not_in_recipe = Food.where.not(id: @recipe.foods.pluck(:id))
  
        if params[:recipe].present? && params[:recipe][:food_ids].present?
          food_ids = params[:recipe][:food_ids].reject(&:empty?) # Remove empty strings
          @recipe.foods << Food.where(id: food_ids)
          flash[:notice] = 'Ingredients added successfully.'
          redirect_to @recipe
          return
        end
      else
        flash[:alert] = 'You do not have permission to add ingredients to this recipe.'
      end
  
      render 'add_ingredient'
    end
  