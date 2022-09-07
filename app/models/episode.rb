# frozen_string_literal: true

class Episode < ApplicationRecord
  belongs_to :book

  has_many :user_episodes, dependent: :destroy
  has_many :users, through: :user_episodes

  has_many :categories, through: :book

  rating

  validates :book_id, :state, :publication_date, :duration, :mp3_url, :preview_url, :affiliate_link,
            :price, :edito, :notes, presence: { if: :state_is_ready? }
  validates :book_id, :mp3_url, :preview_url, :affiliate_link, uniqueness: true

  after_save :set_publication, if: :state_is_ready?

  def rounded_rating
    rating.average.to_i
  end

  def set_publication
    EpisodePublisherJob.set(wait_until: published_at).perform_later(self)
    update(state: 'queuing')
  end

  def state_is_ready?
    state == 'ready'
  end

  def notify_members
    User.all.find_each do |user|
      UserMailer.episode_published(user, self).deliver_later
    end
  end
end
