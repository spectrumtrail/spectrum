class EventDecorator < Draper::Decorator
  delegate_all

  def location_name
    location.name
  end

  def row_thumbnail
    logo.variant(resize: "100x100")
  end

  def name_with_location
    "#{name} @ #{location.name}"
  end
end
