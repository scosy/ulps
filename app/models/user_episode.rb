class UserEpisode < ApplicationRecord
    belongs_to :user
    belongs_to :episode

    validates :user_id, uniqueness: { scope: :episode_id }
end