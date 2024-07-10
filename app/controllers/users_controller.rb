class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    if @user != current_user
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
    @posts = @user.posts  # Load posts associated with this user
  end

  def edit
    @user = current_user
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end

