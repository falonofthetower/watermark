class Image < ActiveRecord::Base
  has_many :sidekiq_jobs, as: :driveable
  belongs_to :user
end
