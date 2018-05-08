# frozen_string_literal: true

# hahaha
class User < ApplicationRecord
  before_create :generate_authentication_token

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

  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post

  # friendship
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where('friendships.accept = 1') }, through: :friendships
  has_many :waiting, -> { where('friendships.accept = 0') }, through: :friendships, source: :friend

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, -> { where('friendships.accept = 1') }, through: :inverse_friendships, source: :user
  has_many :accept_or_not, -> { where('friendships.accept = 0') }, through: :inverse_friendships, source: :user

  after_validation :default_avatar

  def admin?
    role == 'admin'
  end

  def waiting?(user)
    waiting.include?(user)
  end

  def accept_or_not?(user)
    accept_or_not.include?(user)
  end

  def friend?(user)
    friends.include?(user) & inverse_friends.include?(user)
  end

  def all_friends
    friends & inverse_friends
  end

  def collecting?(post)
    collected_posts.include?(post)
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def default_avatar
    if !self.avatar?
      self.remote_avatar_url = "http://www.gogecko.com.au/images/avatar.png"
      self.save
    end
  end
end
