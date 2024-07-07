class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.authenticate(params[:user][:password_challenge]) && current_user.update(password_params)
      redirect_to edit_password_path, notice: "Your password has been updated successfully"
    else
      current_user.errors.add(:password_challenge, 'is incorrect') unless current_user.authenticate(params[:user][:password_challenge])
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
