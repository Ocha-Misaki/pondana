class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author
      t.text :description
      t.string :store_url, null: false

      t.timestamps
    end
    add_index :books, %i[title store_url], unique: true
  end
end
