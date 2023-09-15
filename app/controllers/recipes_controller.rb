class RecipesController < ApplicationController
  # before_action :authenticate_user!, except: [:show]

  def index
    @recipes = Recipe.includes(:recipe_foods).where(user_id: current_user.id)
  end

  def new
    @recipe = Recipe.new
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id])
  
    if current_user == @recipe.user
      # Fetch foods associated with the recipe through the join table
      @foods_in_recipe = @recipe.recipe_foods.includes(food: :user).map(&:food)
  
      # Fetch foods not associated with the recipe
      @foods_not_in_recipe = Food.where.not(id: @foods_in_recipe.map(&:id))
  
      if params[:recipe].present? && params[:recipe][:food_ids].present?
        food_ids = params[:recipe][:food_ids].reject(&:empty?) # Remove empty strings
  
        # Create new rows in the join table to associate selected foods with the recipe
        food_ids.each do |food_id|
          @recipe.recipe_foods.create(food_id: food_id)
        end
  
        flash[:notice] = 'Ingredients added successfully.'
        redirect_to @recipe
        return
      end
    else
      flash[:alert] = 'You do not have permission to add ingredients to this recipe.'
    end
  
    render 'add_ingredient'
  end

  def remove_food_from_recipe
    @recipe_food = RecipeFood.includes(:food).find_by(recipe_id: params[:id], food_id: params[:food_id])
    @recipe_food.destroy
    redirect_to recipe_path(params[:id])
  end

  def public_recipes
    @users = User.includes(:recipes).all
    @foods = Food.includes(:recipe_foods).all
    @public_recipes = Recipe.includes(:user, :recipe_foods).where(public: true).order(created_at: :desc)
    @current_user = current_user
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
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe successfully deleted'
    else
      redirect_to recipes_path, notice: 'Recipe could not be deleted'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @toggle_recipe_public = params[:toggle_recipe_public]
  
    # Ensure that the current user owns the recipe or it's public
    if @recipe.user == current_user || @recipe.public
      @recipe_foods = @recipe.recipe_foods.includes(:food)
      return unless @toggle_recipe_public
  
      @recipe.update(public: !@recipe.public)
      flash[:notice] = @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = 'You do not have permission to view this recipe.'
      redirect_to recipes_path
    end
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
