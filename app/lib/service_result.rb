class ServiceResult
  attr_accessor :success, :object, :message

  def initialize(success: false, object: nil, message: "")
    @success = success
    @object = object
    @message = message
  end

  def success?
    success
  end
end
