class RaceDecorator < Draper::Decorator
  delegate_all

  def card_image_cap
    h.url_for(event.logo)
  end

  def default_cover_photo_url
    if cover_photo.attached?
      helpers.url_for(cover_photo)
    else
      "https://images.unsplash.com/photo-1524150078-1cd6d1eae568?ixlib=rb-1.2.1&auto=format&fit=crop&w=2851&q=80"
    end
  end

  def default_logo_url
    if logo.attached?
      helpers.url_for(logo)
    else
      helpers.asset_path("logo-no-text")
    end
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
