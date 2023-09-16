class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, dependent: :destroy
  has_many :foods

  attribute :name, :text
  attribute :preparation_time, :integer
  attribute :cooking_time, :integer
  attribute :description, :text
  attribute :public, :text

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :public, inclusion: { in: [true, false] }
end
