# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :active_follows, class_name:  "Follow",
                            foreign_key: "user_id",
                            dependent:   :destroy
  has_many :passive_follows, class_name:  "Follow",
                             foreign_key: "followed_user_id",
                             dependent:   :destroy
  has_many :following, through: :active_follows, source: :followed_user
  has_many :followers, through: :passive_follows, source: :user

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
