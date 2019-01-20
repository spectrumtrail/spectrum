class LocationDecorator < Draper::Decorator
  delegate_all

  def form_name_hint
    "The public name of the host location. Example: 'Davis Mountains State Park'"
  end

  def row_thumbnail
    location.cover_photo.variant(resize: "50x50")
  end
end
