class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @location = @event.location
    @races = @event.races.active.order(starts_at: :asc)
  end

  private
    def set_event
      @event = Event.friendly.find(params[:id]).decorate
    end
end
