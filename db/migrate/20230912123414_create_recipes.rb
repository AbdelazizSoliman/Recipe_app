class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :preparation_time
      t.string :cooking_time
      t.string :integer
      t.string :description
      t.string :string
      t.string :public
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
