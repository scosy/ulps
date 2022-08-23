class Episode < ApplicationRecord
    belongs_to :book

    has_many :user_episodes, dependent: :destroy
    has_many :users, through: :user_episodes

    has_many :categories, through: :book

    rating

    def rounded_rating
        self.rating.average.to_i
    end
end
