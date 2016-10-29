class AddTitleToPdf < ActiveRecord::Migration
  def change
    add_column :pdfs, :title, :string
  end
end
