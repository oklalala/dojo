# frozen_string_literal: true

# hahaha
class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  is_impressionable counter_cache: true, column_name: :viewed_count
  # save count of view the post.

  belongs_to :user

  # scope :all_can_see, -> { where.not(who_can_see: %w[self friend]) }
  # scope :friend_can_see, -> (user){ where.not(who_can_see: 'self')
  #   .or(where(who_can_see: 'friend').where(user_id: user)) }

  #   scope :all_can_see, -> { where.not(who_can_see: %w[self friend]) }
  # scope :friend_only, ->(user) {
  #   where(who_can_see: 'friend').where(user_id: user)
  # }
  # scope :friend_can_see, ->(user) {
  #   where(who_can_see: ['all', nil])
  #     .or(where(who_can_see: 'friend').where(user_id: 'test'))
  # }
  has_many :sorts, dependent: :destroy
  has_many :categories, through: :sorts

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user

  def collected?(user)
    collected_users.include?(user)
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

  def who_can_see?(user)
    if user_id == user && who_can_see == 'self'
      puts 'my self'
      Post.all
    elsif self.user.friend?(user) && who_can_see == 'friend'
      puts 'my friend'
      Post.friend_can_see(user)
    else
      puts 'all'
      Post.all_can_see
    end
  end

  def publish?
    status == 'publish'
  end

  def draft?
    status == 'draft'
  end
end
