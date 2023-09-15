class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

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

  def remove_food
    @recipe = Recipe.find(params[:id])
    @food = Food.find(params[:food_id])
    if current_user == @recipe.user
      @recipe.foods.delete(@food)
      flash[:notice] = 'Ingredient removed successfully.'
    else
      flash[:alert] = 'You do not have permission to remove ingredients from this recipe.'
    end
    redirect_to @recipe
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).includes(:foods)
    @total_food_items = Food.sum(:quantity)
    @total_price = Food.joins(:recipe_foods).sum('foods.quantity * foods.price')
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:notice] = 'Recipe created successfully.'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:alert] = 'Recipe creation failed.'
      redirect_to new_recipe_url
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      @recipe.recipe_foods.destroy_all

      @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully.'
    else
      flash[:alert] = 'You do not have permission to delete this recipe.'
    end
    redirect_to recipes_path
  end

  def show
    @recipe = Recipe.find(params[:id])
    @toggle_recipe_public = params[:toggle_recipe_public]
    return unless @toggle_recipe_public && @recipe.user == current_user

    @recipe.update(public: !@recipe.public)
    flash[:notice] = @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
    redirect_to recipe_path(@recipe)
  end

  def toggle_recipe_public
    @recipe = Recipe.find(params[:id])

    if @recipe.user == current_user
      @recipe.update(public: !@recipe.public)
      flash[:notice] = @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
    else
      flash[:alert] = 'You do not have permission to toggle this recipe.'
    end

    redirect_to @recipe
  end

  def generate_shopping_list
    @recipe = Recipe.find(params[:id])

    @required_foods = @recipe.foods.where.not(user: current_user).includes(:user)
    @total_value = @required_foods.sum { |food| food.quantity * food.price }
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
