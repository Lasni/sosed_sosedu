require 'pry-byebug'
class PostsController < ApplicationController
  before_action :set_user, only: [:create, :destroy,]
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = Post.all
  end

  def show
    # The set_post before_action will handle setting @post
  end

  def new
  end

  def create
    # binding.pry

    @post = @user.posts.build(post_params)
    @post.author = @user.username
    # TODO
    # @post.longitude = post_params[:longitude]
    # @post.latitude = post_params[:latitude]
    
    if @post.save
      redirect_to user_path(@user), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(@user), notice: 'Post was successfully deleted.', status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def post_params
    params.require(:post).permit(:body, :latitude, :longitude)
  end
end
