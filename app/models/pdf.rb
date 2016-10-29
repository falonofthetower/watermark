class Pdf < ActiveRecord::Base
  belongs_to :user
  has_many :sidekiq_jobs
  belongs_to :project
end
