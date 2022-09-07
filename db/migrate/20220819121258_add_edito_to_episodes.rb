# frozen_string_literal: true

class AddEditoToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :edito, :string
  end
end
