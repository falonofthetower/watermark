class CreatePdf < ActiveRecord::Migration
  def change
    create_table :pdfs do |t|
      t.integer :user_id
      t.string :file_id
      t.text :parents
    end
  end
end
