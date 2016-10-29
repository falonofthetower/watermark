class AddGoogleDriveIdToPdfs < ActiveRecord::Migration
  def change
    add_column :pdfs, :google_drive_id, :string
    add_column :pdfs, :upload_source, :string
    add_column :pdfs, :content_type, :string
  end
end
