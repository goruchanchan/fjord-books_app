class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :followed_user_id

      t.timestamps
    end
    add_index :follows, :user_id
    add_index :follows, :followed_user_id
    add_index :follows, [:user_id, :followed_user_id], unique: true
  end
end
