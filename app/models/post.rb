class Post < ApplicationRecord
  # include Visible

  belongs_to :user
  has_many :messages, dependent: :destroy
end
