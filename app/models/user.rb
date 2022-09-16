# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar

  has_many :active_follows, class_name: 'Follow',
                            dependent: :destroy

  has_many :passive_follows, class_name: 'Follow',
                             foreign_key: 'followed_user_id',
                             inverse_of: :user,
                             dependent: :destroy

  has_many :followings, through: :active_follows, source: :followed_user

  has_many :followers, through: :passive_follows, source: :user

  def follow(other_user)
    followings << other_user unless followings.include?(other_user)
  end

  def unfollow(other_user)
    active_follows.find_by(followed_user_id: other_user.id).destroy if followings.include?(other_user)
  end

end
