class EventDecorator < ApplicationDecorator
  def default_cover_photo_url
    if cover_photo.attached?
      helpers.url_for(cover_photo)
    else
      helpers.asset_path("logo-no-text")
    end
  end

  def default_logo_url
    if logo.attached?
      helpers.url_for(logo)
    else
      helpers.asset_path("logo-no-text")
    end
  end

  def location_name
    location.name
  end

  def starts_at_date_string
    Time.use_zone(time_zone) do
      starts_at.strftime("%A %B %d, %Y")
    end
  end

  def local_registration_window_opens_text
    helpers.local_time(registration_opens_at, '%B %e, %Y %l:%M%P %Z')
  end

  def local_registration_window_closes_text
    helpers.local_time(registration_closes_at, '%B %e, %Y %l:%M%P %Z')
  end

  def row_thumbnail
    logo.variant(resize: "100x100")
  end

  def name_with_location
    "#{name} @ #{location.name}"
  end
end
