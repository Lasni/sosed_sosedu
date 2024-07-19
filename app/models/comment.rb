class Comment < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :post, dependent: :destroy

  validates :body, presence: true

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Noticed::Event'
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  private

  def cleanup_notifications
    # notifications_as_comment.destroy_all
    post.notifications.where(id: post.id).destroy_all
  end

  def notify_recipient
    CommentNotifier.with(record: self, post: post).deliver_later(post.user)
  end
end
