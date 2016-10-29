class FileCommand < ActiveRecord::Base
  belongs_to :user
  serialize :parents, Array
  serialize :statuses, Array

  def refresh_token
    user.refresh_token
  end
end
