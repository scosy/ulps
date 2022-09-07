# frozen_string_literal: true

class CreateUserEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_episodes do |t|
      t.integer :user_id
      t.integer :episode_id

      t.timestamps
    end
  end
end
