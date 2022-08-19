class CreateBookCategory < ActiveRecord::Migration[7.0]
  def change
    create_table :book_categories do |t|
      t.integer :category_id
      t.integer :book_id

      t.timestamps
    end
  end
end
