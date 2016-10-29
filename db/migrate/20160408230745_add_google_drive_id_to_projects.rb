class AddGoogleDriveIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :google_drive_id, :string
  end
end
