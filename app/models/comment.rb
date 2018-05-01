# frozen_string_literal: true

# hi
class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true

  def photo?
    nil
  end
end
