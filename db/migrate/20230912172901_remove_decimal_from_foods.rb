class RemoveDecimalFromFoods < ActiveRecord::Migration[7.0]
  def change
    remove_column :foods, :decimal, :string
    remove_column :foods, :integer, :string
  end
end
