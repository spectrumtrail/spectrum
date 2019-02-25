class LocationDecorator < Draper::Decorator
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

  def form_name_hint
    "The public name of the host location. Example: 'Davis Mountains State Park'"
  end

  def row_thumbnail
    location.cover_photo.variant(resize: "100x100")
  end
end
