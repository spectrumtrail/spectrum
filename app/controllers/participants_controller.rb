class ParticipantsController < ApplicationController
  before_action :set_event_and_race
  before_action :set_race

  def index
    @participants = @race.participants.for_start_list.decorate
  end

  private

  def set_event
    @event = Event.friendly.find(params[:event_id]).decorate
    @race = @event.races.friendly.find(params[:race_id]).decorate
  end
end
