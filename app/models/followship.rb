# frozen_string_literal: true

# rubocop
class Followship < ApplicationRecord
  validates :friend_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def friend?(user)
    following?(user) && user.accept
  end
end
