class Oauth2Controller < ApplicationController
  before_filter :require_user

  def redirect
    set_refresh_token
    insert_file
    return_to_previous
  end

  private

  def set_refresh_token
    @user = User.find(current_user.id)
    refresh_token = request.env["omniauth.auth"]["credentials"]["refresh_token"]
    @user.update_column("refresh_token", refresh_token)
  end

  def insert_file
    FileCreation.new(@user).create
  end
end
