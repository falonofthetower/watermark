module DriveWrapper
  Drive = Google::Apis::DriveV2
  Apis = Google::Apis

  class File
    attr_reader :data, :upload_source, :content_type, :parents, :file
    attr_accessor :file

    def self.build(file)
      @file = file
      Drive::File.new(
        id: id,
        title: title,
        parents: parents,
        mime_type: mime_type
      )
    end

    def self.title
      @file.title
    end

    def self.id
      @file.file_id || ""
    end

    def self.mime_type
      # prefix = "application/vnd.google-apps"
      # return @file.mime_type if @file.mime_type == "pdf"
      # return @file.mime_type if @file.mime_type.starts_with? prefix
      # "#{prefix}.#{@file.mime_type}"
    end

    def self.parents
      @file.parents.collect { |parent| {id: parent} }
    end
  end

  class Service
    attr_reader :client, :error_message, :response
    attr_accessor :service

    def initialize(options = {})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.insert_file(data, client, options = {})
      service.authorization = client
      response = service.insert_file(
        data,
        upload_source: options[:upload_source],
        content_type: options[:content_type],
      )

      new(response: response)
    rescue Apis::Error => e
      new(error_message: e.message)
    end

    def self.get_file(file_id, client, options = {})
      service.authorization = client
      response = service.get_file(
        file_id,
        download_dest: options[:download_dest]
      )

      new(response: response)
    rescue Google::Apis::ClientError => e
      new(error_message: e)
    end

    def self.generate_file_ids(client, max_results)
      service.authorization = client
      response = service.generate_file_ids(max_results: max_results)

      new(response: response)
    rescue Apis::Error => e
      new(error_message: e.message)
    end

    def self.list_files(client, max_results=100)
      service.authorization = client
      response = service.generate_file_ids(max_results: max_results)

      new(response: response)
    rescue Apis::Error => e
      new(error_message: e.message)
    end

    def successful?
      response.present?
    end

    def id
      response.id if self.successful?
    end

    def self.service
      @service ||= Drive::DriveService.new
    end
  end
end
