class ParticipantsController < ApplicationController
  before_action :set_event
  before_action :set_race

  def index
    @participants = @race.participants.with_payment.order(:first_name)
  end

  private

  def set_event
    @event = Event.friendly.find(params[:event_id]).decorate
  end

  def set_race
    @race = @event.races.find(params[:race_id]).decorate
  end
end
