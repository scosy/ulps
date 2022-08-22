class UsersController < ApplicationController
  before_action :authenticate_user!

  def my_account
    @user = current_user
  end
end
