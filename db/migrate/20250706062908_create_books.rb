class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.text :description, null: false
      t.string :store_url, null: false

      t.timestamps
    end
    add_index :books, %i[title store_url], unique: true
  end
end
