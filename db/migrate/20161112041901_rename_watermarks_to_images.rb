class RenameWatermarksToImages < ActiveRecord::Migration
  def change
    rename_table :watermarks, :images
  end
end
