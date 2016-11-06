class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :sidekiq_jobs
  has_one :google_id_pool
  has_many :watermarks, dependent: :destroy
  before_create :build_google_id_pool

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.refresh_token = auth.credentials.refresh_token
      user.google_id_pool = GoogleIdPool.new
      user.save!
    end
  end

  def new_drive_id
    google_id_pool.pop
  end
end
