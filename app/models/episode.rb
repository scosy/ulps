class Episode < ApplicationRecord
    belongs_to :book

    has_many :user_episodes, dependent: :destroy
    has_many :users, through: :user_episodes

    has_many :categories, through: :book

    rating

    validates_presence_of :book_id, :state, :published_at, :duration, :mp3_url, :preview_url, :affiliate_link, :price, :edito, :notes
    validates_uniqueness_of :book_id, :mp3_url, :preview_url, :affiliate_link

    def rounded_rating
        self.rating.average.to_i
    end
end
