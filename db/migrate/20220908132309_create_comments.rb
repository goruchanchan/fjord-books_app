class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text  :content
      t.references :imageable, polymorphic: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
