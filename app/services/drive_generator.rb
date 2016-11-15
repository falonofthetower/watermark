class DriveGenerator < Driveable
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def access_token
    self.client.access_token
  end
end
