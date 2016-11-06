class PdfPreparer < Preparer
  def title
    subject.title
  end

  def parents
    [subject.project.google_drive_id]
  end
end
