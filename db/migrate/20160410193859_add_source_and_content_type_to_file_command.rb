class AddSourceAndContentTypeToFileCommand < ActiveRecord::Migration
  def change
    add_column :file_commands, :upload_source, :string
    add_column :file_commands, :content_type, :string
  end
end
