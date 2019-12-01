class RacesController < ApplicationController
  before_action :set_event
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  def index
    @races = @event.races.active.not_archived.order(starts_at: :asc)
  end

  def show
  end

  private

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end

  def set_race
    @race = Race.friendly.find(params[:id])
  end
end
