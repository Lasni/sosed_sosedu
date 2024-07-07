class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  normalizes :email, with: ->(email) {email.strip.downcase}

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  private

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
end
