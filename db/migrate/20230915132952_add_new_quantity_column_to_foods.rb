class AddNewQuantityColumnToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :new_quantity, :decimal
  end
end
