class Food < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :measurement_unit, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end
