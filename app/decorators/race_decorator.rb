class RaceDecorator < Draper::Decorator
  delegate_all

  def card_image_cap
    h.url_for(event.logo)
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
end
