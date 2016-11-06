class AddGoogleDriveIdToWatermark < ActiveRecord::Migration
  def change
    add_column :watermarks, :google_drive_id, :string
  end
end
