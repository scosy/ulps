# frozen_string_literal: true

class AddStateToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :state, :string, default: 'draft'
  end
end
