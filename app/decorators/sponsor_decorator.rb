class SponsorDecorator < ApplicationDecorator
  delegate_all

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

end
