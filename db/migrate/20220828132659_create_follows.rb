class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :userID, index: true
      t.integer :followed_userID, index: true

      t.timestamps
    end
    add_foreign_key :follows, :users, column: :userID
    add_foreign_key :follows, :users, column: :followed_userID
  end
end
