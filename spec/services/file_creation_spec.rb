require 'spec_helper'

describe FileCreation do
  describe "#initialize" do
    it "sets prepared to the Preparer for the subject" do
      object = Object.new
      string = String.new
      object_preparer = double("ObjectPreparer")
      string_preparer = double("StringPreparer")
      stub_const("ObjectPreparer", object_preparer)
      stub_const("StringPreparer", string_preparer)
      expect(ObjectPreparer).to receive(:new).with(object).and_return(object_preparer)
      expect(StringPreparer).to receive(:new).with(string).and_return(string_preparer)

      FileCreation.new(object)
      FileCreation.new(string)
    end
  end

  describe ".create" do
    let(:user) { Fabricate(:user) }
    let(:object) { Object.new }
    let(:object_preparer) { double("ObjectPreparer") }

    before do
      stub_const("ObjectPreparer", object_preparer)
      allow(ObjectPreparer).to receive(:new).with(object).and_return(object_preparer)
      allow(ObjectPreparer).to receive_messages(
        subject: user,
        user: user,
        file_id: "file_id",
        title: "Amazing Title",
        parents: [],
        mime_type: "mimey wimey"
      )
      FileCreation.new(object).create
    end

    it "creates a file_command with the preparer" do
      expect(FileCommand.count).to eq(1)
    end

    it "sets the user id" do
      expect(FileCommand.last.user_id).to eq(user.id)
    end

    it "sets the title" do
      expect(FileCommand.last.title).to eq("Amazing Title")
    end

    it "sets the parents" do
      expect(FileCommand.last.parents).to eq([])
    end

    it "sets the mime_type" do
      expect(FileCommand.last.mime_type).to eq("mimey wimey")
    end

    it "sets the file_id" do
      expect(FileCommand.last.file_id).to eq("file_id")
    end

    it "dispatches a file insertion" do
      expect(FileInserter.jobs.size).to eq(1)
    end

    it "updates the drive_id for the subject" do
      expect(user.reload.google_drive_id).to eq("file_id")
    end
  end
end
