class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable # ポリモーフィック用
end
