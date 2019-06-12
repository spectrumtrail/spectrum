class SeriesDecorator < ApplicationDecorator
  def default_cover_photo_url
    if cover_photo.attached?
      helpers.url_for(cover_photo)
    else
    asset_path("logo-no-text")
    end
  end

  def default_logo_url
    if logo.attached?
      helpers.url_for(logo)
    else
      helpers.asset_path("logo-no-text")
    end
  end
end
