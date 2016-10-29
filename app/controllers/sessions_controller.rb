class SessionsController < ApplicationController
  def new
    redirect_to root_path if session[:user_id]
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome to Iolite"
      redirect_to root_path
    else
      flash[:danger] = "Your sign in failed!"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been signed out!"
    redirect_to sign_in_path
  end
end
