class FileInserter < Driveable
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  attr_accessor :metadata, :file, :token

  def perform(command_id)
    command = FileCommand.find(command_id)
    @metadata = FileWrapper.build(command)
    @token = command.refresh_token

    ServiceWrapper.insert_file(
      metadata,
      client,
      upload_source: command.upload_source,
      content_type: command.content_type
    )
  end
end
