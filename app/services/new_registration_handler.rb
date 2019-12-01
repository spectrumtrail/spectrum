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
    # This controls whether or not someone can create a new registration
    # for a race belonging to this event. This prevents users from creating
    # registrations for different, active, not-archived, races belonging to the
    # same running of this event (example: the 2019 Sky Island vs 2020 Sky Island)

    @existing_participant ||= event.participants.where(
      race_id: registerable_race_ids
    ).created_after(
      # Important: this scope relies on the 'registration opens at' setting to
      # be accurate.
      event.registration_opens_at
    ).where(email: submitted_participant.email).first
  end

  def registerable_race_ids
    # Important: this is to prevent past registrations for races belonging to
    # the same event from being retrieved at signup for the next years' races
    # belonging to that event.

    @event.races.active.not_archived.pluck(:id)
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
