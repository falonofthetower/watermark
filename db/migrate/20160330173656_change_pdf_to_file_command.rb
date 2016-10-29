class ChangePdfToFileCommand < ActiveRecord::Migration
  def change
    rename_table :pdfs, :file_commands
  end
end
