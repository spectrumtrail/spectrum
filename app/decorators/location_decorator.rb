class LocationDecorator < ApplicationDecorator
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

  def form_name_hint
    "The public name of the host location. Example: 'Davis Mountains State Park'"
  end

  def row_thumbnail
    location.cover_photo.variant(resize: "100x100")
  end
end
