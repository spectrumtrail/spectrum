class ParticipantDecorator < ApplicationDecorator
  def address_html
    "#{address}<br />#{city}, #{state}, #{zip}"
  end

  def city_and_state
    "#{participant.city.try(:titleize)}, #{participant.state.try(:upcase)}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def race_name
    race.name
  end

  def race_day_age
    diff = birth_date - event.starts_at
    distance = diff / 1.year
    distance.abs.to_i
  rescue
    0
  end
end
