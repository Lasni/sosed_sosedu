class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)  # Ensure post_params include :author, :body
    
    if @post.persisted?
      redirect_to user_path(@user), notice: 'Post was successfully created.'
    else
      render :new  # Handle validation errors
    end
  end

  private

  def post_params
    params.require(:post).permit(:author, :body)
  end
end
