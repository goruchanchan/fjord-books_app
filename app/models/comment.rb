class Comment < ApplicationRecord
  belongs_to :user # 外部キー用
  belongs_to :commentable, polymorphic: true # ポリモーフィック用
end
