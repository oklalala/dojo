# ahhaha
class Category < ApplicationRecord
  has_many :sorts, dependent: :destroy
  has_many :posts, through: :sorts
end
