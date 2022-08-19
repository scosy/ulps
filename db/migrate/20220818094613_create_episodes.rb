class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.integer :book_id
      t.integer :creator_id
      t.integer :duration
      t.string :affiliate_link
      t.string :mp3_url
      t.string :preview_url

      t.timestamps
    end
  end
end
