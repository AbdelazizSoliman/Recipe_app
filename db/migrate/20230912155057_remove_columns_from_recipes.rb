class RemoveColumnsFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :string, :string
  end
end
