class RegistrationsController < ApplicationController
  before_action :set_event
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def new
    @race = Race.find params[:race_id]
    @registration = @event.registrations.new
    @participants = @registration.participants.new(race_id: params[:race_id])
  end

  def create
    @registration = @event.registrations.new(registration_params)

    if @registration.save
      redirect_to(
        # this will be navigating to a form just for waivers.
        # might be on the registration, might be just the
        # registration update action, we shall see.
        edit_event_registration_path(@event, @registration)
      )
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @registration.update(registration_params)
      redirect_to(
        event_registration_path(@event, @registration),
        success: "Registration was successfully updated."
      )
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.friendly.find params[:event_id]
  end

  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit!
  end
end
