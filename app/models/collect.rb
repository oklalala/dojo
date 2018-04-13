# hahaha
class Collect < ApplicationRecord
  # validates :collecting_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :post
end
