class Post < ApplicationRecord
  # include Visible

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :notifications, through: :user, dependent: :destroy
  has_many :notification_mentions, through: :user, dependent: :destroy
  has_noticed_notifications model_name: 'Noticed::Notification'
end
