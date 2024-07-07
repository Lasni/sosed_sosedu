class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  normalizes :email, with: ->(email) {email.strip.downcase}
end
