require 'spec_helper'

describe SignetWrapper, :vcr do
  describe SignetWrapper::Client do
    describe ".authorize" do
      context "with valid token" do
        it "returns an authorized client" do
          google_user = Fabricate(:google_user)
          client = SignetWrapper::Client.authorize(google_user.refresh_token)
          expect(client).to be_successful
        end
      end

      context "without valid token" do
        describe ".authorize" do
          it "returns an error" do
            user = Fabricate(:user)
            response = SignetWrapper::Client.authorize(user.refresh_token)
            expect(response.error_message).to be_present
          end
        end
      end
    end
  end
end
