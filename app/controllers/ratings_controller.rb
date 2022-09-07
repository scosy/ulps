# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_episode
  skip_before_action :verify_authenticity_token

  def create
    current_user.rate @episode, rating_params[:rounded_rating] if current_user&.episodes&.include?(@episode)
  end

  private

  def rating_params
    params.require(:episode).permit(:rounded_rating)
  end

  def set_episode
    @episode = Episode.find(params[:episode_id])
  end
end
