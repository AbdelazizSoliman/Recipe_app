class RecipeFood < ApplicationRecord
  belongs_to :recipe, foreign_key: 'recipe_id'
  belongs_to :food, foreign_key: 'food_id'

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :recipe_id, presence: true, uniqueness: { scope: :food_id }
  validates :food_id, presence: true, uniqueness: { scope: :recipe_id }
end
