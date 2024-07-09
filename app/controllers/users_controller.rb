class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts  # Load posts associated with this user
  end

  def edit
    @user = current_user
  end

  def update
  end

  private

end

