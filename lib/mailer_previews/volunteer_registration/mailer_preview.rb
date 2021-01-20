class VolunteerRegistration::MailerPreview < ActionMailer::Preview
  def confirm
    VolunteerRegistrationMailer.with(volunteer: Volunteer.all.sample).confirm
  end

  def notify
    VolunteerAdminNotificationMailer.with(volunteer: Volunteer.all.sample).notify
  end
end
