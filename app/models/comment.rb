# frozen_string_literal: true

# hi
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def photo?
    nil
  end
end
