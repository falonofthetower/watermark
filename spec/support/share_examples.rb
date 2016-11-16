shared_examples "requires google auth" do
  it "redirects to the oauth path" do 
    session[:user_id] = nil
    action
    expect(response).to redirect_to google_oauth2_path
  end
end

