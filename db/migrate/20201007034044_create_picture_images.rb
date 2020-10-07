class CreatePictureImages < ActiveRecord::Migration[5.2]
  def change
    create_table :picture_images do |t|
      t.integer :picture_id
      t.string :image_id
      t.timestamps
    end
  end
end
