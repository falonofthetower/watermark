class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method(
    :current_user,
    :logged_in?,
    :require_user,
    :require_google_auth,
    :return_to_previous
  )

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    access_denied unless current_user
  end

  def access_denied
    flash[:danger] = "You don't have the authorization for that!"
    redirect_to sign_in_path
  end

  def require_google_auth
    make_drive_accessible unless drive_accessible?
  end

  def drive_accessible?
    current_user and current_user.refresh_token
  end

  def make_drive_accessible
    session[:return_to] ||= request.path
    redirect_to google_oauth2_path
  end

  def return_to_previous
    (redirect_to session.delete(:return_to)) || (redirect_to root_path)
  end
end
