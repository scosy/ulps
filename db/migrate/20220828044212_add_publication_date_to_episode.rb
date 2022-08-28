class AddPublicationDateToEpisode < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :publication_date, :datetime
  end
end
