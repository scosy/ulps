class AddEditoToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :edito, :string
  end
end
