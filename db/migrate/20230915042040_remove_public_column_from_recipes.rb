class RemovePublicColumnFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :public
    rename_column :recipes, :new_public, :public
  end
end
