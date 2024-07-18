# To deliver this notification:
#
# NewMessageNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewMessageNotifier < ApplicationNotifier

  deliver_by :action_cable do |config|
    config.channel = "NotificationsChannel"
    config.stream = ->{ recipient }
    config.message = ->{ params.merge(user_id: recipient.id) }
  end
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

  # Add required params
  #
  # required_param :message
  # 
  notification_methods do
    # I18n helpers
    def message
      t(".message")
    end

    # URL helpers are accessible in notifications
    # Don't forget to set your default_url_options so Rails knows how to generate urls
    def url
      user_post_path(recipient, params[:post])
    end
  end
end
