class UserPreparer
  attr_accessor :subject, :user, :title, :file_id, :parents, :mime_type

  def initialize(subject)
    @subject = subject
  end

  def file_id
    @file_id ||= subject.new_drive_id
  end

  def user
    subject
  end

  def title
    "Iolite"
  end

  def parents
    []
  end

  def mime_type
    "folder"
  end
end
