class EventsController < ApplicationController
  before_action :set_event, except: [:index]

  def index
    redirect_to root_path(anchor: 'EventsGrid')
  end

  def show
    if @event.present? && @event.is_active?
      @location = @event.location
      @races = @event.races.active.order(starts_at: :asc)
    else
      redirect_to(
        root_path,
        notice: "This event is no longer active."
      )
    end
  end

  private

  def set_event
    @event = Event.with_attachments.friendly.find(params[:id]).try(:decorate)
  end
end
