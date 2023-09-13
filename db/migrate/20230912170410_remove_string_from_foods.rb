class RemoveStringFromFoods < ActiveRecord::Migration[7.0]
  def change
    remove_column :foods, :string, :string
  end
end
