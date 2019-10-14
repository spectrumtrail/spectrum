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
    h.distance_of_time_in(:year, event.starts_at, birth_date) rescue 0
  end
end
