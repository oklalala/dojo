# frozen_string_literal: true

# hahaha
class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user

  has_many :sorts, depenednt: :destroy
  has_many :sorted_categories, through: :sorts, source: :category

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  has_many :comments, dependent: :destroy

  def collected?(user)
    collected_user.include?(user)
  end
end
