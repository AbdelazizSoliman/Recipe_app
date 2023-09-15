class Recipe < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :recipe_foods, dependent: :destroy
  has_and_belongs_to_many :foods, join_table: :recipe_foods
  # attr_accessor :food_ids

  attribute :name, :text
  attribute :preparation_time, :integer
  attribute :cooking_time, :integer
  attribute :description, :text
  attribute :public, :text

  validates :name, presence: true, length: { maximum: 250 }
  validates :description, presence: true
  validates :cooking_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :preparation_time, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
