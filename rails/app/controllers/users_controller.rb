class UsersController < ApplicationController
  before_action :authenticate_if_initialized!

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to projects_path, notice: "Success"
    else
      redirect_to root_path, alert: "Error: " + @user.errors.full_messages.join(", ")
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def authenticate_if_initialized!
    if User.count > 0
      authenticate!
    else
      true
    end
  end
end