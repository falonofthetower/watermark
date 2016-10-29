class CreateSidekiqJobs < ActiveRecord::Migration
  def change
    create_table :sidekiq_jobs do |t|
      t.string :job_id
      t.integer :user_id
      t.integer :pdf_id
      t.timestamps
    end
  end
end
