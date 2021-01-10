class VolunteerNotification::MailerPreview < ActionMailer::Preview
  def notify
    VolunteerNotificationMailer.with(volunteer: Volunteer.all.sample).notify
  end
end
