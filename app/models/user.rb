class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, stretches: 13

  validates :name, presence: true, length: { maximum: 250 }

  has_many :recipes, class_name: 'Recipe', foreign_key: 'user_id', dependent: :destroy
  has_many :foods, class_name: 'Food', foreign_key: 'user_id', dependent: :destroy
end
