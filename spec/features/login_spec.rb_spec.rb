require 'spec_helper'

feature "user flattens pdf" do

  scenario "user adds pdf and then flattens it" do
    visit root_path
    expect_sign_in_page
    user_sign_in
    save_and_open_page

    # sign_into_google
    # upload_image
    # fill_in_form_with("gibberish")
    # expect_success_message
  end

  def sign_into_google
    save_and_open_page
  end

  def expect_sign_in_page
    expect(page.has_content?("Sign In")).to be_truthy
    expect(page.has_content?("Sign Out")).to be_falsy
    expect(page.has_content?("Sign Up")).to be_truthy
  end
end
