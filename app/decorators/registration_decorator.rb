class RegistrationDecorator < Draper::Decorator
  delegate_all

  def event_name
    event.name
  end

  def participant_name
    participant.full_name
  end

  def race_day_age
    h.distance_of_time_in_words(participant.birth_date, event.starts_at)
  end

  def race_name
    participant.race.name
  end
end
