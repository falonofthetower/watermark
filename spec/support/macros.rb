def set_current_user(user = nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def set_current_google_user(user = nil)
  session[:user_id] = (user || Fabricate(:google_user)).id
end

def user_sign_in(user = nil, password = nil)
  user ||= Fabricate(:user)
  password ||= user.password
  fill_in "Email Address", with: user.email
  fill_in "Password", with: password
  click_button "Sign In"
end
