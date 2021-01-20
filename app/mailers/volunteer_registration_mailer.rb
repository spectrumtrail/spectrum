class VolunteerRegistrationMailer < ApplicationMailer
  layout 'volunteer_registration'

  attr_accessor :volunteer

  def confirm
    @volunteer = params[:volunteer]
    @event = volunteer.event.decorate

    mail(
      to: @volunteer.email,
      subject: "Thank you for signing up to volunteer with Spectrum Trail Racing!"
    )
  end
end
