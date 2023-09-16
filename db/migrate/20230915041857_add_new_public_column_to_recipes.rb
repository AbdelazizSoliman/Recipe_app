class AddNewPublicColumnToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :new_public, :boolean, default: false
  end
end
