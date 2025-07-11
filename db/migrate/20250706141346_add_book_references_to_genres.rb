class AddBookReferencesToGenres < ActiveRecord::Migration[8.0]
  def change
    add_reference :books, :genre, null: false, foreign_key: true
  end
end
