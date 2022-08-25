class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[ show edit update destroy get_episode ]
  before_action :only_admin, only: %i[ new edit create update destroy ]

  # GET /episodes or /episodes.json
  def index
    @episodes = Episode.all.where(state: "published").order(published_at: :desc)
    # Filter by category_id if present in episode.categories
    if params[:category_id]
      @episodes = @episodes.select { |episode| episode.categories.include?(Category.find(params[:category_id])) }
    end
    # Filter by creator_id if present in episode.creator
    if params[:creator_id]
      @episodes = @episodes.select { |episode| episode.creator.id == params[:creator_id].to_i }
    end
    # Filter by search if present in episode.title
    if params[:search]
      @episodes = @episodes.select { |episode| episode.title.downcase.include?(params[:search].downcase) }
    end
  end

  # GET /user_episodes
  def user_episodes
    @user_episodes = UserEpisode.where(user_id: current_user.id).order(created_at: :desc)
    @episodes = @user_episodes.map { |user_episode| user_episode.episode }
    render :index
  end

  # GET /episodes/1 or /episodes/1.json
  def show
    # Check if user has this episode
    if current_user && current_user.episodes.include?(@episode)
        @user_episode = UserEpisode.where(user_id: current_user.id, episode_id: @episode.id).first
    end
  end

  # User get an episode
  def get_episode
    # Check if user has this episode
    if current_user && current_user.episodes.include?(@episode)
        redirect_to episode_url(@episode), notice: "Vous avez déjà cet épisode."
    else
      # Check if user has enough credits
      if current_user.available_credits > 0
        @user_episode = UserEpisode.new(user_id: current_user.id, episode_id: @episode.id)
        @user_episode.save
        current_user.update(available_credits: current_user.available_credits - 1)
        redirect_to episode_url(@episode)
      else
        redirect_to episode_url(@episode), notice: "Crédits insuffisants."
      end  
    end
  end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes or /episodes.json
  def create
    @episode = Episode.new(episode_params)

    respond_to do |format|
      if @episode.save
        format.html { redirect_to episode_url(@episode), notice: "Épisode créé avec succès" }
        format.json { render :show, status: :created, location: @episode }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /episodes/1 or /episodes/1.json
  def update
    respond_to do |format|
      if @episode.update(episode_params)
        format.html { redirect_to episode_url(@episode), notice: "Épisode mis à jour avec succès." }
        format.json { render :show, status: :ok, location: @episode }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /episodes/1 or /episodes/1.json
  def destroy
    @episode.destroy

    respond_to do |format|
      format.html { redirect_to episodes_url, notice: "Épisode supprimé avec succès." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def episode_params
      params.require(:episode).permit(:title, :book_id, :creator_id, :duration, :affiliate_link, :mp3_url, :preview_url, :notes, :rounded_rating, :state, :published_at)
    end
end
