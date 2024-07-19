class Post < ApplicationRecord
  # include Visible

  belongs_to :user
  has_many :comments, dependent: :destroy
end
