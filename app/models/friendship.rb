# frozen_string_literal: true

# friendship
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :accept, -> { where(accept: true) }
  scope :not_accept, -> { where(accept: false) }
end
