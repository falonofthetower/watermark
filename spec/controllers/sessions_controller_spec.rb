require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template(:new)
    end

    it "redirects to the home page for authenticated users" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    context "for valid user credentials" do
      let(:edward) { Fabricate(:user) }
      before do
        post :create, email: edward.email, password: edward.password
      end

      it "redirects to the home page" do
        expect(response).to redirect_to root_path
      end

      it "sets the user in the setting" do
        post :create, email: edward.email, password: edward.password
        expect(session[:user_id]).to eq(edward.id)
      end

      it "sets the flash success message" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "for invalid user credentials" do
      before do
        post :create
      end

      it "redirects to the sign in path" do
        expect(response).to redirect_to sign_in_path
      end

      it "does not set the user in the setting" do
        expect(session[:user_id]).to be_nil
      end

      it "sets the flash failure message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    before do
      set_current_user
      get :destroy
    end

    it "redirects to the sign in path" do
      expect(response).to redirect_to sign_in_path
    end

    it "removes the user from the session" do
      expect(session[:user_id]).to be_nil
    end

    it "sets the flash message" do
      expect(flash[:success]).not_to be_blank
    end
  end
end
