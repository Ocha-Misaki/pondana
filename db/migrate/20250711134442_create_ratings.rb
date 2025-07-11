class CreateRatings < ActiveRecord::Migration[8.0]
  def change
    create_table :ratings do |t|
      t.integer :readability, null: false, default: 0
      t.integer :recommendation, null: false, default: 0
      t.integer :helpfulness, null: false, default: 0
      t.references :having_book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
