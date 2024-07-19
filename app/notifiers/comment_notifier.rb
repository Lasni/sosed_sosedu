# To deliver this notification:
#
# CommentNotifier.with(record: @post, message: "New post").deliver(User.all)
require 'pry-byebug'
class CommentNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end
  deliver_by :database

  # Add required params
  #
  # required_param :message
  # 
  def message
    # test
    # @post = CommentNotifier.find(id).params[:post]
    # @user = User.find((CommentNotifier.find(id).params[:post].user_id))
    @post = record.post
    @user = record.user
    # "#{@user.name} replied to #{@post.title.truncate(14)}"
    # binding.pry
    "#{@user.username} replied to #{@post.body}#{@post.id}"
  end
  
  def url
    # post_path(CommentNotifier.find(id).params[:post].id)
    post_path(record.post.id)
  end
end
