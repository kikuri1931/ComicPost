class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :genre
      t.boolean :is_active , default: true, null: false
      t.timestamps
    end
  end
end
