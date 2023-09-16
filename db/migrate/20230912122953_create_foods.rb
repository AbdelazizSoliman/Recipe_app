class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :measurement
      t.string :unit
      t.string :string
      t.string :price
      t.string :decimal
      t.string :quantity
      t.string :integer
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
