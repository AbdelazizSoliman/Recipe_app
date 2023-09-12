class RemoveIntegerFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :integer, :string
  end
end
