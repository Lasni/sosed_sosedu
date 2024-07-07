class SessionsController < ApplicationController
  # logout
  def destroy
    logout current_user
    redirect_to root_path, notice: "You have been logged out"
  end

  # login
  def new
  end

  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    if user
      login user
      redirect_to root_path, notice: "You have been signed in successfully"
    else
      flash[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
end