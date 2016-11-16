class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method(
    :current_user,
    :logged_in?,
    :require_user,
    :require_google_auth,
    :return_to_previous
  )
  before_action :prep_gon

  def prep_gon
    @gon_items = {}
  end

  def current_user
    logger.debug "debug #{__method__}"
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    logger.debug "debug #{__method__}"
    !!current_user
  end

  def require_user
    logger.debug "debug #{__method__}"
    access_denied unless current_user
  end

  def access_denied
    logger.debug "debug #{__method__}"
    flash[:danger] = "You don't have the authorization for that!"
    redirect_to google_oauth2_path
  end

  def require_google_auth
    logger.debug "debug #{__method__}"
    make_drive_accessible unless drive_accessible?
  end

  def require_google_auth_user
    logger.debug "debug #{__method__}"
    unless logged_in?
      require_google_auth
    end
  end

  def drive_accessible?
    logger.debug "debug #{__method__}"
    current_user and current_user.refresh_token
  end

  def make_drive_accessible
    logger.debug "debug #{__method__}"
    session[:return_to] ||= request.path
    redirect_to google_oauth2_path
  end

  def return_to_previous
    logger.debug "debug #{__method__}"
    (redirect_to session.delete(:return_to)) || (redirect_to root_path)
  end
end
