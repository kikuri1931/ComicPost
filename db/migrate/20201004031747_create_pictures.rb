class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.integer :genre_id
      t.integer :picture_content_id
      t.string :picture_id
      t.integer :status
      t.integer :user_status
      t.timestamps
    end
  end
end
