class UserEpisode < ApplicationRecord
    belongs_to :user
    belongs_to :episode

    validates_uniqueness_of :user_id, scope: :episode_id

    after_create :notify_user

    def notify_user
        user.episode_obtained(episode)
    end
end