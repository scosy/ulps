class Episode < ApplicationRecord
    belongs_to :book

    has_many :user_episodes, dependent: :destroy
    has_many :users, through: :user_episodes
end
