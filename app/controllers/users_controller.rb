class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Iolite"
      redirect_to sign_in_path
    else
      flash.now[:danger] = "Welcome to Iolite"
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
