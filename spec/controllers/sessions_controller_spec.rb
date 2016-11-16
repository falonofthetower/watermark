require 'spec_helper'

describe SessionsController do
  describe "GET destroy" do
    before do
      set_current_user
      get :destroy
    end

    it "removes the user from the session" do
      expect(session[:user_id]).to be_nil
    end
  end
end
