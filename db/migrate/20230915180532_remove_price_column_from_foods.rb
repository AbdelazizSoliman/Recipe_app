class RemovePriceColumnFromFoods < ActiveRecord::Migration[7.0]
  def change
    remove_column :foods, :price
    rename_column :foods, :new_price, :price
  end
end
