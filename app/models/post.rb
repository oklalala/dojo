# frozen_string_literal: true

# hahaha
class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  is_impressionable counter_cache: true, column_name: :viewed_count
  # save count of view the post.

  belongs_to :user

  has_many :sorts, dependent: :destroy
  has_many :categories, through: :sorts

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user

  def replies_count
    comments.count
  end

  def collected?(user)
    collected_user.include?(user)
  end

  def last_reply
    if comments.last
      comments.last.created_at.strftime('%Y-%m-%d')
    else
      created_at.strftime('%Y-%m-%d')
    end
  end

  def photo?
    !photo.url.empty? unless photo.url.nil?
    nil
  end

  def set_draft
    self.status = 'draft'
    save
  end

  def publish?
    status == 'publish'
  end

  def draft?
    status == 'draft'
  end
end
