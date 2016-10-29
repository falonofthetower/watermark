class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :email
  validates_presence_of :password, presence: true, on: :create
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :sidekiq_jobs
  has_one :google_id_pool

  def new_drive_id
    google_id_pool.pop
  end
end
