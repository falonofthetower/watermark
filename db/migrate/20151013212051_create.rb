class Create < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :access_token
      t.string :refresh_token
    end
  end
end
