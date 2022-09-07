# frozen_string_literal: true

class AddNotesToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :notes, :text
  end
end
