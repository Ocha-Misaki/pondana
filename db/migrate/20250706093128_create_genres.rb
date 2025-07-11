class CreateGenres < ActiveRecord::Migration[8.0]
  def change
    create_table :genres do |t|
      t.string :name, null: false
      t.string :store_genre_id, null: false

      t.timestamps
    end
    add_index :genres, [:name, :store_genre_id], unique: true
  end
end
