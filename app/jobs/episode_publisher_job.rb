class EpisodePublisherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    episode = args[0]
    episode.update(state: "published")
    episode.notify_members
  end
end
