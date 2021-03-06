class RaceDecorator < ApplicationDecorator
  def card_image_cap
    h.url_for(event.logo)
  end

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

  def name_with_event
    "#{event.name} #{name}"
  end

  def name_with_event_and_year
    "#{event.name} #{name} (#{starts_at.year})"
  end

  def name_with_event_and_price
    "#{name_with_event} - ($#{price_in_cents / 100})"
  end

  def registration_radio_input_name
    string = name_with_event
    if is_full?
      string += " <em class='text-danger'>(Sold Out)</em>"
    else
      string += " - ($#{price_in_cents / 100})"
    end
    string.html_safe
  end

  def name_with_price
    if is_full?
      name + " <em class='text-danger'>(Sold Out)</em>"
    else
      name + " - ($#{price_in_cents / 100})"
    end
  end

  def price_in_dollars
    helpers.number_to_currency(race.price_in_cents / 100, precision: 0)
  end

  def participants_count
    participants.size
  end

  def row_thumbnail
    event.decorate.row_thumbnail
  end

  def start_date_and_time_with_zone
    start_date + ' ' + start_time_with_zone
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

  def pending_revenue
    race.participants.not_archived.abandoned_registrations.size * (race.price_in_cents / 100)
  end

  def paid_not_cancelled_count
    participants.not_archived.with_payment.not_cancelled.size
  end
end
