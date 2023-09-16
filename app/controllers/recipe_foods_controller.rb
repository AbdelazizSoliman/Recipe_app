class RecipeFoodsController < ApplicationController
  def index; end

  def show; end

  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all.where(user_id: current_user.id)
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe = Recipe.find(params[:recipe_food][:recipe_id])

    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_path(@recipe), notice: 'Recipe Food was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        @foods = Food.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(@recipe_food.recipe_id)
    @foods = Food.all
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(@recipe_food.recipe_id)

    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        format.html { redirect_to recipe_path(@recipe_food.recipe_id), notice: 'Recipe Food was successfully updated.' }
        format.json { render :show, status: :created, location: @recipe_food }
      else
        @foods = Food.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_to recipe_path, notice: 'Recipe Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
