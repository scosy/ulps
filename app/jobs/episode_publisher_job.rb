# frozen_string_literal: true

class EpisodePublisherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    episode = args[0]
    episode.update(state: 'published', published_at: Time.zone.now)
    episode.notify_members
  end
end
