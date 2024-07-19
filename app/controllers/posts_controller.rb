class PostsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = if params[:post_type].present?
      Post.where(post_type: params[:post_type])
    else
      Post.all
    end
  end

  def show
    # The set_post before_action will handle setting @post
    mark_notifications_as_read
  end

  def new
    @post = Post.new
  end

  def create
    unless (post_params[:post_type].present? && post_params[:body].present?)
      flash[:notice] = "You must select a post type and write some content."
      return redirect_to user_path(@user)
    end

    @post = @user.posts.build(post_params)
    @post.author = @user.username
    @post.latitude = post_params[:latitude]
    @post.longitude = post_params[:longitude]
    @post.post_type = post_params[:post_type]

    
    # binding.pry

    if @post.save
      redirect_to user_path(@user), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    @post.comments.destroy_all
    @post.delete
    redirect_to user_path(@user), notice: 'Post was successfully deleted.', status: :see_other
  end

  private

  def mark_notifications_as_read
    return unless current_user
  
    notifications_to_mark_as_read = @post.notifications.where(recipient: current_user)
    notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def post_params
    params.require(:post).permit(:body, :latitude, :longitude, :post_type)
  end
end
