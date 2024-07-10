class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @message = @post.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to post_path(@post), notice: 'Message was successfully created.'
    else
      redirect_to post_path(@post), alert: 'Message could not be created.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
