class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    name = food_params[:name]
    measurement_unit = food_params[:measurement_unit]
    quantity = food_params[:quantity]
    price = food_params[:price]
    food = Food.new(name:, measurement_unit:, price:, quantity:)

    if food.save
      redirect_to foods_path, notice: 'Food created successfully!'
    else
      render :new, notice: 'An error occured while creating a new food'
    end
  end

  def destroy
    redirect_to root_path
  end

  def delete
    @food = Food.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food deleted successfully!'
    else
      redirect_to foods_path, alert: 'Unable to delete the food item.'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
