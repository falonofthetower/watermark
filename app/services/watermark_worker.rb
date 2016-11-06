class WatermarkWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  attr_reader :google_id, :client, :drive, :metadata, :folder_path, :text
  attr_accessor :service

  def expiration
    @expiration ||= 60*60*24*30 # 30 days
  end

  def service
    DriveWrapper::Service
  end

  def setup(id)
    @watermark = Watermark.find(id)
    token =  User.find(@watermark.user.id).refresh_token

    @client = SignetWrapper::Client.authorize(token).response

    @google_id = @watermark.google_id

    @metadata = service.get_file(self.google_id, client).response
    @folder_path = create_tmp_folder
    @text = @watermark.text
  end

  def create_tmp_folder
    tmp_path = Rails.root.join('tmp')
    temp_folder = "#{metadata.id}#{Time.new.to_i}"

    Dir.mkdir("#{tmp_path}/#{temp_folder}")
    return "#{tmp_path}/#{temp_folder}"
  end

  def download
    service.get_file(google_id, client, download_dest: "#{original_file_path}")
  end

  def apply
    `convert '#{original_file_path}' -font Arial -pointsize 20 -draw "gravity south fill black text 0,12 '#{text}' fill white text 1,11 '#{text}'" "#{new_file_path}"`
  end

  def original_file_path
    "#{folder_path}/#{@metadata.original_filename}"
  end

  def new_file_path
    "#{folder_path}/watermarked_#{@metadata.original_filename}"
  end

  def upload
    @watermark.update_attributes(title: @metadata.title)
    FileCreation.new(@watermark).create(
      upload_source: "#{new_file_path}",
      content_type: 'image/jpeg'
    )
  end

  def post_process
    #`rm -rf "#{@folder_path}"`
  end

  def perform(id)
    total 100
    setup(id)
    at 15, "Getting started"
    download
    at 50, "Retriving File"
    apply
    at 70, "Performing magic"
    upload
    at 90, "Returning File"
    post_process
    at 100, "Ahhh, much better"
  end
end
