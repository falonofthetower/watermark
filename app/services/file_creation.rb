class FileCreation
  attr_reader :error_message

  def initialize(subject)
    @prepared = "#{subject.class.to_s}Preparer".constantize.new(subject)
  end

  def create(options={})
    @prepared.subject.update_attributes(google_drive_id: @prepared.file_id)

    @file_command = FileCommand.create(
      file_id: @prepared.file_id,
      user_id: @prepared.user.id,
      title: @prepared.title,
      parents: @prepared.parents,
      mime_type: @prepared.mime_type,
      upload_source: options[:upload_source],
      content_type: options[:content_type]
    )

    FileInserter.perform_async(@file_command.id)
  end
end
