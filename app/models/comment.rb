# frozen_string_literal: true

# hi
class Comment < ApplicationRecord
  belongs_to :post, counter_cache: :comments_count
  belongs_to :user
end
