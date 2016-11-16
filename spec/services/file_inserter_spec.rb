require 'spec_helper'

describe FileInserter do
  describe "perform" do
    let(:user) { Fabricate(:google_user) }
    let(:file_command) { Fabricate(:file_command, user: user) }
    let(:special_file_command) { Fabricate(:file_command, user: user, upload_source: "cool/location", content_type: "ninja nunchucks") }
    let(:client) { instance_double("SignetWrapper::Client", response: "valid client") }

    before do
      allow(DriveWrapper::File).to receive(:build).with(file_command).and_return("metadata")
      allow(DriveWrapper::File).to receive(:build).with(special_file_command).and_return("metadata")
      allow(SignetWrapper::Client).to receive(:authorize).with(file_command.refresh_token).and_return(client)
    end

    it "sets the token" do
      expect(file_command.refresh_token).to eq(user.refresh_token)
      FileInserter.new.perform(file_command.id)
    end

    it "sends the insert file message" do
      expect(DriveWrapper::Service).to receive(:insert_file)
      FileInserter.new.perform(file_command.id)
    end

    it "sends the file with client to ServiceWrapper" do
      expect(DriveWrapper::Service).to receive(:insert_file).with("metadata", "valid client", upload_source: "cool/location", content_type: "ninja nunchucks")
      FileInserter.new.perform(special_file_command.id)
    end
  end
end
