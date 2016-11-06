class CreateWatermark < ActiveRecord::Migration
  def change
    create_table :watermarks do |t|
      t.references :user, foreign_key: true
      t.string :google_id
    end
  end
end
