# frozen_string_literal: true

# hahaha
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, PhotoUploader
  # user name can't be the same or pop out the error.
  validates_presence_of :name
  # can't_friend_yourself
  validates :name, uniqueness: { case_sensitive: true,
                                 message: 'has already been taken' }
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy, counter_cache: true
  has_many :commented_posts, through: :comments, source: :post

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects

  # friendship
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :user
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id'
  has_many :require_friends, through: :inverse_friendships, source: :user

  def admin?
    role == 'admin'
  end

  def friending?(user)
    friendings.include?(user)
  end

  def friend?
    friending? && friendships.accept
  end

  def was_ignored?
    friending? && !friendship.accept
  end

  def collecting?(post)
    collected_posts.include?(post)
  end
end
