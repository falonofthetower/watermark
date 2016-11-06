class ImageFetcher
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  attr_reader :file_id, :client, :drive, :metadata, :folder_path
  attr_accessor :service

  def expiration
    @expiration ||= 60*60*24*30 # 30 days
  end

  def service
    DriveWrapper::Service
  end

  def setup(id)
    @pdf = Pdf.find(id)
    token =  User.find(@pdf.user.id).refresh_token

    @client = SignetWrapper::Client.authorize(token).response

    @file_id = @pdf.file_id

    @metadata = service.get_file(self.file_id, client).response
    @folder_path = create_tmp_folder
  end

  def create_tmp_folder
    tmp_path = Rails.root.join('tmp')
    temp_folder = "#{metadata.id}#{Time.new.to_i}"

    Dir.mkdir("#{tmp_path}/#{temp_folder}")
    return "#{tmp_path}/#{temp_folder}"
  end

  def download
    service.get_file(file_id, client, download_dest: "#{folder_path}/pdf.pdf")
  end

  # def flatten
  #   `convert -density 150 "#{folder_path}/pdf.pdf" '#{folder_path}/pdf.png'`
  #   entries = Dir.entries("#{folder_path}").keep_if {|entry| entry.split('.')[1] == "png" }
  #   entries.sort_by! {|filename| File.ctime("#{folder_path}/#{filename}") }
  #   entries.map! {|file| "'#{folder_path}/#{file}'"}
  #   string = entries.join(" ")
  #   `convert #{string} "#{folder_path}/#{@metadata.title}.pdf"`
  # end

  # def upload
  #   @pdf.update_attributes(title: metadata.title)
  #   FileCreation.new(@pdf).create(
  #     upload_source: "#{folder_path}/#{metadata.title}.pdf",
  #     content_type: 'application/pdf'
  #   )
  # end


  # def post_process
  #   #`rm -rf "#{@folder_path}"`
  # end

  def perform(id)
    total 100
    setup(id)
    at 15, "Getting started"
    download
    at 50, "Retriving File"
    flatten
    at 70, "Performing magic"
    upload
    at 90, "Returning File"
    post_process
    at 100, "Ahhh, much better"
  end
end
