require 'pry-byebug'
class PostsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]
  before_action :set_post, only: [:destroy]

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)  # Ensure post_params include :author, :body
    @post.author = @user.email
    
    if @post.save
      redirect_to user_path(@user), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity  # Handle validation errors
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
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
