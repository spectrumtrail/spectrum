class RegistrationDecorator < Draper::Decorator
  delegate_all

  def event_name
    event.name
  end

  def event_race_name
    event.name + " - " + race.name
  end

  def event_race_name_link
    h.link_to event_race_name, h.admin_event_path(event)
  end

  def participant_name
    participant.full_name
  end

  def participant_name_link
    h.link_to participant_name, h.admin_participant_path(participant)
  end

  def payment_details_link
    if payment.present?
      h.link_to h.number_to_currency(payment.amount_charged_in_dollars), "#coming soon"
    else
      "No Payment"
    end
  end

  def race_day_age
    h.distance_of_time_in_words(participant.birth_date, event.starts_at)
  end

  def race_name
    participant.race.name
  end
end
