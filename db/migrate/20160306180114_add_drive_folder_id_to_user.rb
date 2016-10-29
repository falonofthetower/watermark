class AddDriveFolderIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :google_drive_folder_id, :string
  end
end
