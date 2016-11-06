class AddIndexToSidekiqJobs < ActiveRecord::Migration
  def change
    add_index :sidekiq_jobs, [:driveable_id, :driveable_type]
  end
end
