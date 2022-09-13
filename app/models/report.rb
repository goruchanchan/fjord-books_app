# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy # ポリモーフィック用、日報削除されたらコメントも削除
end
