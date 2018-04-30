# frozen_string_literal: true

# friendship
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :accept, -> { where(accept: true) }
  scope :not_accept, -> { where(accept: false) }
  scope :exist, ->(id) { where(friend_id: id) }
  scope :inverse_exist, ->(id) { where(user_id: id) }
end
