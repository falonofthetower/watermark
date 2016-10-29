class RenameUserDriveId < ActiveRecord::Migration
  def change
    rename_column :users, :google_drive_folder_id, :google_drive_id
  end
end
