require 'pry-byebug'
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @recipient = User.find(@post.user_id)
    # binding.pry

    if @comment.save
      ActionCable.server.broadcast("NotificationsChannel", {
        turbo_stream: render_to_string(
          turbo_stream: turbo_stream.append("notifications", partial: "notifications/notification", locals: { notification: CommentNotifier::Notification.last })
        ),
        unread_count: @recipient.notifications.unread.count 
      })
      redirect_to post_path(@post), notice: 'Comment was successfully created.'
    
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
