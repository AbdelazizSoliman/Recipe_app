class AddNewPriceColumnToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :new_price, :decimal
  end
end
