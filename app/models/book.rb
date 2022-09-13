# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_many :comments, as: :commentable, dependent: :destroy # ポリモーフィック用、本削除されたらコメントも削除
end
