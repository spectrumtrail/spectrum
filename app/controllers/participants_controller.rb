class ParticipantsController < ApplicationController
  before_action :set_event
  before_action :set_race

  def index
    @participants = @race.participants.for_start_list.order(:first_name).decorate
  end

  private

  def set_event
    @event = Event.friendly.find(params[:event_id]).decorate
  end

  def set_race
    @race = @event.races.friendly.find(params[:race_id]).decorate
  end
end
