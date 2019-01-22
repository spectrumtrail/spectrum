class RaceDecorator < Draper::Decorator
  delegate_all

  def row_thumbnail
    event.decorate.row_thumbnail
  end

  def name_with_event
    "#{event.name} #{name}"
  end
end
