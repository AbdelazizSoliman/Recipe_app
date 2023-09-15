class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods.all
  end

  def new
    @user = current_user
    @food = Food.new
  end

  def show
    @food = Food.find(params[:id])
  end

  def destroy
    puts 'Destroy action called'
    @food = Food.find(params[:id])
    if @food.user == current_user
      @food.destroy
      redirect_to foods_path, notice: 'Food deleted successfully!'
    else
      redirect_to foods_path, alert: 'You do not have permission to delete this food item.'
    end
  end

  def shopping_list
    foods = Food.includes(:recipe_foods).where({ user_id: current_user.id })
    @shopping_list = []
    @total_price = 0
    foods.each do |food|
      shopping_list_item = {
        food: food.name,
        quantity: calculate_missing_food(food),
        unit: food.measurement_unit,
        unit_price: food.price
      }
      @total_price += shopping_list_item[:quantity] * shopping_list_item[:unit_price]
      @shopping_list << shopping_list_item if (shopping_list_item[:quantity]).positive?
    end
  end

  # controllers/foods_controller.rb
  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully added.'
    else
      render :new
    end
  end

  private
  def calculate_missing_food(food)
    missing_food = -food.quantity
    food.recipe_foods.each do |recipe_food|
      missing_food += recipe_food.quantity
    end

    return 0 if missing_food <= 0

    missing_food
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
