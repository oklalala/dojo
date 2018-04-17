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
  # can't_follow_yourself
  validates :name, uniqueness: { case_sensitive: true,
                                 message: 'has already been taken' }
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects

  # Following Follower
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: 'Followship',
                                 foreign_key: 'friend_id'
  has_many :followers, through: :inverse_followships, source: :user

  def admin?
    role == 'admin'
  end

  def following?(user)
    followings.include?(user)
  end
end
