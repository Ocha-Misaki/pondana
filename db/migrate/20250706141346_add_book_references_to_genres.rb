class AddBookReferencesToGenres < ActiveRecord::Migration[8.0]
  def change
    add_reference :genres, :book, null: false, foreign_key: true
  end
end
