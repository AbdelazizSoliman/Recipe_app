class RemoveQuantityColumnFromFoods < ActiveRecord::Migration[7.0]
  def change
    remove_column :foods, :quantity
    rename_column :foods, :new_quantity, :quantity
  end
end
