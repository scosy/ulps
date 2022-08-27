class UsersController < ApplicationController
  before_action :authenticate_user!

  def my_account
    @user = current_user
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
