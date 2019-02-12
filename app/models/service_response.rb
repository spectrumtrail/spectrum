class ServiceResponse
  attr_accessor :message, :object, :success

  def initialize(message:, object:, success:)
    @message = message
    @object = object
    @success = success
  end

  def success?
    success
  end

  def flash_status
    if success
      :success
    else
      :danger
    end
  end

  def flash_message
    message
  end
end
