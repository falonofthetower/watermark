class ChangePdfIdToDriveableOnSidekiqJobs < ActiveRecord::Migration
  def change
    rename_column :sidekiq_jobs, :pdf_id, :driveable_id
    add_column :sidekiq_jobs, :driveable_type, :string
  end
end
