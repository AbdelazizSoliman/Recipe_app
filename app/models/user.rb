class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 250 }

  has_many :recipes, class_name: 'Recipe', foreign_key: 'user_id', dependent: :destroy
  has_many :foods, class_name: 'Food', foreign_key: 'user_id', dependent: :destroy
  has_many :recipe_foods, through: :recipes, join_table: :recipe_foods
end
