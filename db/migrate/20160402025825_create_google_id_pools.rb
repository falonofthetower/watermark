class CreateGoogleIdPools < ActiveRecord::Migration
  def change
    create_table :google_id_pools do |t|
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
