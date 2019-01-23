class RaceDecorator < Draper::Decorator
  delegate_all

  def name_with_event
    "#{event.name} #{name}"
  end

  def participants_text
    "#{registrations_count} / #{registrations_limit}"
  end

  def row_thumbnail
    event.decorate.row_thumbnail
  end
end
