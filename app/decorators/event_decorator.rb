class EventDecorator < Draper::Decorator
  delegate_all

  def location_name
    location.name
  end

  def name_with_location
    "#{name} @ #{location.name}"
  end
end
