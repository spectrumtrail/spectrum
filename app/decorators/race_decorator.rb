class RaceDecorator < Draper::Decorator
  delegate_all

  def card_image_cap
    h.url_for(event.logo)
  end

  def name_with_event
    "#{event.name} #{name}"
  end

  def participants_count
    participants.size
  end

  def row_thumbnail
    event.decorate.row_thumbnail
  end

  def start_time_with_zone
    Time.use_zone(time_zone) do
      starts_at.strftime("%I:%M %p (%Z)")
    end
  end

  def start_date
    Time.use_zone(time_zone) do
      starts_at.strftime("%A %B %d, %Y")
    end
  end
end
