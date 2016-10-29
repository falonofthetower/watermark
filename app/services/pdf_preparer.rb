class PdfPreparer
  attr_accessor :subject, :user, :title, :file_id, :parents, :mime_type

  def initialize(subject)
    @subject = subject
  end

  def file_id
    @file_id ||= user.new_drive_id
  end

  def user
    subject.user
  end

  def title
    subject.title
  end

  def parents
    [subject.project.google_drive_id]
  end

  def mime_type
    "pdf"
  end
end
