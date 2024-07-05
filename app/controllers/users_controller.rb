class UsersController < ApplicationController

  http_basic_authenticate_with name: "grega", password: "secret", except: [:index, :show]

  # SHOW USERS/USER
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # NEW USER
  # form action (renders new.html.erb)
  def new
    @user = User.new
  end

  # create action
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  # EDIT USER
  # form action (renders edit.html.erb)
  def edit
    @user = User.find(params[:id])
  end

  # update action
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE USER
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :status)
  end
end
