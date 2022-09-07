# frozen_string_literal: true

class AddPriceToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :price, :integer
  end
end
