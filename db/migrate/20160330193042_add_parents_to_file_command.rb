class AddParentsToFileCommand < ActiveRecord::Migration
  def change
    add_column :file_commands, :parents, :string
  end
end
