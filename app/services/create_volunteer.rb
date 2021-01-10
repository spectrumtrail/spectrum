class CreateVolunteer
  attr_accessor :volunteer

  def initialize(volunteer:)
    @volunteer = volunteer
  end

  def call
    if volunteer.save
      admin_email_notification
      success_result
    else
      fail_result
    end
  end

  private

  def success_result
    ServiceResult.new(object: volunteer, success: true, message: success_message)
  end

  def success_message
    "Your form submission was a success!"
  end

  def fail_result
    ServiceResult.new(object: volunteer, success: false, message: fail_message)
  end

  def fail_message
    "Aw, snap! Something went wrong. Please try to submit your form again."
  end

  def admin_email_notification
    VolunteerNotificationMailer.with(volunteer: @volunteer).notify.deliver_now
  end
end
