class ParticipantDecorator < ApplicationDecorator
  def address_html
    "#{address}<br />#{city}, #{state}, #{zip}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def race_name
    race.name
  end

  def race_day_age
    h.distance_of_time_in(:year, Time.current, birth_date) rescue 0
  end
end
