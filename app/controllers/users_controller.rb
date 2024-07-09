class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # @posts = @user.posts  # Load posts associated with this user
  end
end

