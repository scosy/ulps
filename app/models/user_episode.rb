# frozen_string_literal: true

class UserEpisode < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  validates :user_id, uniqueness: { scope: :episode_id }

  after_create :notify_user

  def notify_user
    user.episode_obtained(episode)
  end
end
