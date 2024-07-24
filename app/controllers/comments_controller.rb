class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
      ActionCable.server.broadcast("NotificationsChannel", {
        payload: @comment
      })
    else
      redirect_to post_path(@post), alert: 'Comment could not be created.'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    Noticed::Event.where(record_type: 'Comment', record_id: @comment.id ).destroy_all
    Noticed::Notification.where( recipient_type: 'User', recipient_id: current_user.id, event_id: @comment.id ).destroy_all
    @comment.delete
    
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
