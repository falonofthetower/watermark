class AddTitleToWatermark < ActiveRecord::Migration
  def change
    add_column :watermarks, :title, :string
  end
end
