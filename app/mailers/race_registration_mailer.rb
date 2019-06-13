class RaceRegistrationMailer < ApplicationMailer
  track extra: -> { { registration_id: params[:registration].id } }
  attr_accessor :registration

  def confirm
    @registration = params[:registration]
    @event = registration.event.decorate
    @race = registration.race.decorate
    @participant = registration.participant.decorate

    mail(
      to: @registration.participant.email,
      subject: "You're in! See you at the #{@race.name_with_event} starting line."
    )
  end
end
