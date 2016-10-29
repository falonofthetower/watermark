require 'spec_helper'

describe ProjectPreparer do
  let(:user) { Fabricate(:user) }
  let(:project) { Fabricate(:project, user: user) }
  let(:project_preparer) { ProjectPreparer.new(project) }

  before do
    allow(user).to receive(:new_drive_id).and_return("fake_id")
  end

  it "returns the id fetched from the user" do
    expect(project_preparer.file_id).to eq("fake_id")
  end

  it "returns the user of the project" do
    expect(project_preparer.user).to eq(user)
  end

  it "returns the title of the supplied project" do
    expect(project_preparer.title).to eq(project.name)
  end

  it "returns the user as its parent" do
    expect(project_preparer.parents).to eq([user.google_drive_id])
  end

  it "returns 'folder' for mime_type" do
    "folder"
  end
end
