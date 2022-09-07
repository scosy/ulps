# frozen_string_literal: true

class AddPublishedAtToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :published_at, :datetime
  end
end
