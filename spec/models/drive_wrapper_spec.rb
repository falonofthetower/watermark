# require 'spec_helper'

# describe DriveWrapper, :vcr do
#   describe DriveWrapper::File do
#     describe ".build" do
#       it "has the correct format for parents" do
#         file_command  = object_double(
#           FileCommand.new,
#           file_id: "fake_id",
#           title: "New Title",
#           mime_type: "type",
#           parents: ["dad", "mom"]
#         )

#         expect(Google::Apis::DriveV2::File).to receive(:new).with(
#           id: "fake_id",
#           title: "New Title",
#           parents: [{id: "dad"}, {id: "mom"}],
#           mime_type: nil
#         )

#         DriveWrapper::File.build(file_command)
#       end

#       it "handles simple mime_type" do
#         file_command = object_double(
#           FileCommand.new,
#           file_id: "fake_id",
#           title: "New Title",
#           mime_type: "type",
#           parents: ["dad", "mom"]
#         )

#         expect(Google::Apis::DriveV2::File).to receive(:new).with(
#           id: "fake_id",
#           title: "New Title",
#           parents: [{id: "dad"}, {id: "mom"}],
#           mime_type: nil
#         )

#         DriveWrapper::File.build(file_command)
#       end
#     end
#   end

#   describe DriveWrapper::Service do
#     let(:google_user) { Fabricate(:google_user) }
#     let(:user) { Fabricate(:user) }
#     let(:file_command) do
#       FileCommand.new(title: "Fake Title", mime_type: "text/plain")
#     end

#     let(:file) do
#       DriveWrapper::File.build(file_command)
#     end

#     let(:good_client) do
#       SignetWrapper::Client.authorize(google_user.refresh_token).response
#     end

#     let(:bad_client) do
#       SignetWrapper::Client.authorize(user.refresh_token).response
#     end

#     let(:valid_file) do
#       DriveWrapper::Service.insert_file(
#         file,
#         good_client,
#         upload_source: Rails.root.join('app/assets/images/test.txt').to_s,
#         content_type: "application/text")
#     end

#     context "with authorized client" do
#       describe "insert_file" do
#         it "It makes a successful insert" do
#           expect(valid_file).to be_successful
#         end

#         it "returns a file id" do
#           expect(valid_file.id).to be_present
#         end
#       end

#       describe "get_file" do
#         let(:response) do
#           DriveWrapper::Service.get_file(valid_file.id, good_client)
#         end

#         it "fetches the file from drive" do
#           expect(response).to be_successful
#         end
#       end
#     end

#     context "without authorized client" do
#       describe ".insert_file" do
#         let(:response) do
#           DriveWrapper::Service.insert_file(
#             file,
#             bad_client,
#             upload_source: Rails.root.join('app/assets/tmp/test.txt').to_s,
#             content_type: "application/text"
#           )
#         end

#         it "returns Unauthorized" do
#           expect(response.error_message).to be_present
#         end
#       end

#       describe ".get_file" do
#         let(:response) do
#           DriveWrapper::Service.get_file(valid_file.id, bad_client,)
#         end

#         it "doesn't fetch a file" do
#           expect(response.error_message).to be_present
#         end
#       end
#     end
#   end
# end
