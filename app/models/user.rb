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
  has_many :collected_posts, through: :collects, source: :post

  # friendship
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def admin?
    role == 'admin'
  end

  # Is there some guy not accept my permision yet?
  # me he not checked
  # he me checked
  # I'm accepting you!!!
  def waiting?(user)
    accepting(user)
  end

  # Is there someone asked me to accept or not?
  # me he checked
  # he me not checked
  # I was accepted.
  def accept_or_not?(user)
    accepted(user)
  end

  def friend?(user)
    accepted(user) && accepting(user)
  end

  def all_friends
    (friendships.accept.friends + inverse_friendships.accept.friends).uniq
  end

  def collecting?(post)
    collected_posts.include?(post)
  end

  private

  # A ask user to accepting
  def accepting(user)
    !inverse_friendships.accept.inverse_exist(user).empty?
  end

  def accepted(user)
    !friendships.accept.exist(user).empty?
  end
end
