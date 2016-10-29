class AddMimeTypeAndTitleToPdf < ActiveRecord::Migration
  def change
    add_column :pdfs, :title, :string
    add_column :pdfs, :mime_type, :string
  end
end
