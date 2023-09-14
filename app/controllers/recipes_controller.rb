class RecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:recipe_foods).where(user_id: current_user.id)
  end

  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def update
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      redirect_to recipe_path(@recipe), notice: 'Recipe could not be upddated'
    end
  end

  def destroy
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])

    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe successfully deleted'
    else
      redirect_to recipes_path, notice: 'Recipe could not be deleted'
    end
  end

  def public_recipes
    @users = User.includes(:recipes).all
    @foods = Food.includes(:recipe_foods).all
    @public_recipes = Recipe.includes(:user, :recipe_foods).where(public: true).order(created_at: :desc)
    @current_user = current_user
  end

  def remove_food_from_recipe
    @recipe_food = RecipeFood.includes(:food).find_by(recipe_id: params[:id], food_id: params[:food_id])
    @recipe_food.destroy
    redirect_to recipe_path(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:public)
  end
end
