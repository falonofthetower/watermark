class RefreshIdPool < Driveable
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  attr_accessor :user, :token

  QUEUE_REFRESH_SIZE = 100

  def perform(user_id)
    @user = User.find(user_id)
    @token = user.refresh_token
    fetch_ids
  end

  def fetch_ids
    request = ServiceWrapper.generate_file_ids(client, QUEUE_REFRESH_SIZE)
    self.user.google_id_pool << request.ids
  end
end
