# This class is responsible for handling the logic when a user/visitor starts
# the registration process. We lean on ActiveRecord to initialize the Registration
# AND the Participant models with the expected associations and attributes.
# This class is responsible for checking to see if someone with this email
# address has already registered for this event. The controller will still
# handle the redirect logic.

class NewRegistrationHandler
  attr_accessor(
    :event,
    :submitted_participant,
    :submitted_registration,
    :existing_participant,
    :existing_registration
  )

  def initialize(registration:)
    @event = registration.event
    @submitted_registration = registration
    @submitted_participant = registration.participant
  end

  def existing_participant
    @existing_participant ||= event.participants.created_after(
      event.registration_opens_at
    ).where(email: submitted_participant.email).first
  end

  def existing_registration
    @existing_registration ||= existing_participant.try(:registration)
  end

  def create_new_registration
    submitted_registration.steps_completed = ["start"]
    submitted_registration.save
    return submitted_registration
  end
end
