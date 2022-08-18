class PublicController < ApplicationController
  before_action :disable_nav, only: :index

  def index
  end

  def privacy
  end

  def conditions
  end
end
