# To deliver this notification:
#
# CommentNotifier.with(record: @post, message: "New post").deliver(User.all)
require 'pry-byebug'
class CommentNotifier < ApplicationNotifier

  deliver_by :database

  deliver_by :action_cable do |config|
    config.channel = "Noticed::NotificationsChannel"
    config.stream = ->{ recipient }
    config.message = ->{ params.merge( user_id: recipient.id) }
  end

  def message
    @post = record.post
    @user = record.user
    "#{@user.username} replied to #{@post.body}#{@post.id}"
  end
  
  def url
    post_path(record.post.id)
  end
end
