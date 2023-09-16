class Food < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  # belongs_to :recipe
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :measurement_unit, presence: true, length: { minimum: 2, maximum: 10 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: BigDecimal(10**3) },
                    format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  validates :quantity, presence: true, numericality: { greater_than: 0, less_than: 10**3 }
end
