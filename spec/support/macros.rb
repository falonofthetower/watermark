def set_current_user(user = nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def set_current_google_user(user = nil)
  session[:user_id] = (user || Fabricate(:google_user)).id
end
