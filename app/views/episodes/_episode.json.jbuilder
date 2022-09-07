# frozen_string_literal: true

json.extract! episode, :id, :title, :book_id, :creator_id, :duration, :affiliate_link, :mp3_url, :preview_url,
              :created_at, :updated_at
json.url episode_url(episode, format: :json)
