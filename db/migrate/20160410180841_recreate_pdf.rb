class RecreatePdf < ActiveRecord::Migration
  def change
    create_table :pdfs do |t|
      t.integer :user_id
      t.string :file_id
      t.integer :project_id
    end
  end
end
