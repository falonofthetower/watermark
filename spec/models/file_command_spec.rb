require 'spec_helper'

describe FileCommand do
  it { is_expected.to belong_to(:user) }
  it { should serialize(:parents).as(Array) }
  it { should serialize(:statuses).as(Array) }

  describe "#refresh_token" do
    it "returns refresh_token from user" do
      user = Fabricate(:google_user)
      file_command = Fabricate(:file_command, user_id: user.id)
      expect(file_command.refresh_token).to eq(user.refresh_token)
    end
  end
end
