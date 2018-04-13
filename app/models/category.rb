# ahhaha
class Category < ApplicationRecord
  has_many :sorts, dependent: :destroy
  has_many :sorted_posts, through: :sorts, source: :post
end
