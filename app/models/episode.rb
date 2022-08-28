class Episode < ApplicationRecord
    belongs_to :book

    has_many :user_episodes, dependent: :destroy
    has_many :users, through: :user_episodes

    has_many :categories, through: :book

    rating

    validates_presence_of :book_id, :state, :published_at, :duration, :mp3_url, :preview_url, :affiliate_link, :price, :edito, :notes
    validates_uniqueness_of :book_id, :mp3_url, :preview_url, :affiliate_link

    # Planifiate the episode to be published after save
    after_save :set_publication, if: :state_is_ready?

    def rounded_rating
        self.rating.average.to_i
    end

    def set_publication
        EpisodePublisherJob.set(wait_until: self.published_at).perform_later(self)
        self.update(state: "queuing")
    end

    def state_is_ready?
        self.state == "ready"
    end

    def notify_members
        User.all.each do |user|
            UserMailer.episode_published(user, self).deliver_later
        end
    end

end
