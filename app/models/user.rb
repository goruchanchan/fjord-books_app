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

  has_many :following, through: :active_follows, source: :followed_user

  has_many :followers, through: :passive_follows, source: :user

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_follows.find_by(followed_user_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
