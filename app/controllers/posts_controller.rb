class PostsController < ApplicationController

  http_basic_authenticate_with name: "grega", password: "secret", only: :destroy

  # CREATE POST
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    redirect_to user_path(@user)
  end

  # DELETE POST
  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(@user), status: :see_other
  end

  private
  def post_params
    params.require(:post).permit(:author, :body, :status)
  end
end
