class AddStatusesToFileCommands < ActiveRecord::Migration
  def change
    add_column :file_commands, :statuses, :string
  end
end
