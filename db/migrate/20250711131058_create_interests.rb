class CreateInterests < ActiveRecord::Migration[8.0]
  def change
    create_table :interests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
    add_index :interests, [:user_id, :book_id], unique: true
    remove_index :interests, :user_id
  end
end
