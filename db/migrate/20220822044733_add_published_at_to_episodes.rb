class AddPublishedAtToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :published_at, :datetime, default: "2022-08-01 04:47:33"
  end
end
