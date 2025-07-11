class CreateHavingBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :having_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :purchased_at, null: false

      t.timestamps
    end
    add_index :having_books, [:user_id, :book_id], unique: true
    remove_index :having_books, :user_id
  end
end
