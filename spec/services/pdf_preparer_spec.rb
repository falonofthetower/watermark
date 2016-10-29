require 'spec_helper'

describe PdfPreparer do
  let(:user) { Fabricate(:user) }
  let(:project) { Fabricate(:project) }
  let(:pdf) { Fabricate(:pdf, user: user, project: project) }
  let(:pdf_preparer) { PdfPreparer.new(pdf) }

  before do
    allow(user).to receive(:new_drive_id).and_return("fake_id")
  end

  it "returns the id fetched from the user" do
    expect(pdf_preparer.file_id).to eq("fake_id")
  end

  it "returns the user of the pdf" do
    expect(pdf_preparer.user).to eq(user)
  end

  it "returns the title of the supplied pdf" do
    expect(pdf_preparer.title).to eq(pdf.title)
  end

  it "returns a drive id supplied from the user" do
    expect(pdf_preparer.parents).to eq([project.google_drive_id])
  end

  it "returns 'pdf' for mime_type" do
    "pdf"
  end
end
