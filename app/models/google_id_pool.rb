class GoogleIdPool < ActiveRecord::Base
  include Redis::Objects

  QUEUE_LOW = 20

  belongs_to :user

  set :ids
  value :state

  def pop
    refresh_queue if low_queue or queue_critical
    ids.pop
  end

  def <<(items)
    ids.<<(items)
    self.state = "fresh"
  end

  private

  def refresh_queue
    RefreshIdPool.perform_async(self.user.id)
    self.state = "refreshing"
  end

  def low_queue
    ids.size < QUEUE_LOW unless state == "refreshing"
  end

  def queue_critical
    ids.size < 5
  end
end
