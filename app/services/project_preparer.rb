class ProjectPreparer
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
    subject.name
  end

  def parents
    [user.google_drive_id]
  end

  def mime_type
    "folder"
  end
end
