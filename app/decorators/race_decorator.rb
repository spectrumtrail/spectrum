class RaceDecorator < Draper::Decorator
  delegate_all

  def name_with_event
    "#{event.name} #{name}"
  end

  def row_thumbnail
    event.decorate.row_thumbnail
  end
end
