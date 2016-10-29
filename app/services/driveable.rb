class Driveable
  FileWrapper = DriveWrapper::File
  ServiceWrapper = DriveWrapper::Service

  def client
    SignetWrapper::Client.authorize(token).response
  end
end
