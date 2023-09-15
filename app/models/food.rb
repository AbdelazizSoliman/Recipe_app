# class Food < ApplicationRecord
#   belongs_to :user, foreign_key: 'user_id'
#   # belongs_to :recipe
#   has_many :recipe_foods, dependent: :destroy

#   validates :name, presence: true, length: { maximum: 100 }
#   validates :measurement_unit, presence: true
#   validates :price, presence: true
#   validates :quantity, presence: true
# end

class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

