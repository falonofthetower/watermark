class WatermarkWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  attr_reader :old_google_id, :new_google_id, :client, :drive, :metadata, :folder_path, :text
  attr_accessor :service

  def expiration
    @expiration ||= 60*60*24*30 # 30 days
  end

  def service
    DriveWrapper::Service
  end

  def setup(images)
    @new_image = Image.find(images["new_image"])
    @old_image = Image.find(images["old_image"])
    token =  User.find(@old_image.user.id).refresh_token

    @client = SignetWrapper::Client.authorize(token).response

    @old_google_id = @old_image.google_id
    @new_google_id = @new_image.google_id

    @metadata = service.get_file(self.old_google_id, client).response
    @folder_path = create_tmp_folder
    @text = @new_image.text
  end

  def create_tmp_folder
    tmp_path = Rails.root.join('tmp')
    temp_folder = "#{metadata.id}#{Time.new.to_i}"

    Dir.mkdir("#{tmp_path}/#{temp_folder}")
    return "#{tmp_path}/#{temp_folder}"
  end

  def download
    service.get_file(self.old_google_id, client, download_dest: "#{original_file_path}")
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
    @new_image.update_attributes(title: @metadata.title)
    FileCreation.new(@new_image).create(
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
