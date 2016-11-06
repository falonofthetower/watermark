class Preparer
  attr_accessor :subject, :user, :title, :file_id, :parents, :mime_type

  def initialize(subject)
    @subject = subject
  end

  def file_id
    @file_id ||= user.new_drive_id
  end

  def title
    subject.title
  end

  def user
    subject.user
  end

  def mime_type
    "pdf"
  end
end
