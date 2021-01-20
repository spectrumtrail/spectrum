class VolunteerAdminNotificationMailer < ApplicationMailer
  layout 'volunteer_admin_notification'
  attr_accessor :volunteer

  def notify
    @volunteer = params[:volunteer]
    @event = volunteer.event.decorate

    mail(
      to: "mallory@spectrumtrailracing.com",
      subject: "New Volunteer registration form submission"
    )
  end
end
