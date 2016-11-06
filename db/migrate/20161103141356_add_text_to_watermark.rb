class AddTextToWatermark < ActiveRecord::Migration
  def change
    add_column :watermarks, :text, :string
  end
end
