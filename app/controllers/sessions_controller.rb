class SessionsController < ApplicationController
  # logout
  def destroy
    log_out current_user
    redirect_to root_path, notice: "You have been logged out"
  end

  # form for login
  def new
  end

  # action for login
  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    if user
      log_in user
      redirect_to root_path, notice: "You have been signed in successfully"
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
end