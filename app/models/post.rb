# frozen_string_literal: true

# hahaha
class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user

  has_many :sorts, dependent: :destroy
  has_many :sorted_categories, through: :sorts, source: :category

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  has_many :comments, dependent: :destroy

  def collected?(user)
    collected_user.include?(user)
  end

  def last_reply
    if comments.last
      comments.last.created_at
    else
      created_at
    end
  end
end
