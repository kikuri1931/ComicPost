class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true, null: false
      t.references :picture_content, foreign_key: true, null: false

      t.timestamps

      t.index [:user_id, :picture_content_id], unique: true
    end
  end
end
