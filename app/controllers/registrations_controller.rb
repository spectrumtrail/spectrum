class RegistrationsController < ApplicationController
  before_action :set_event
  before_action :set_registration, only: [:edit, :update]
  before_action :check_token, only: [:edit, :update]

  def new
    @registration = build_new_registration
    @participant = build_new_participant_for(@registration)
  end

  def create
    @registration = @event.registrations.new(registration_params)

    handler = NewRegistrationHandler.new(registration: @registration)

    if handler.existing_registration.present?
      redirect_to(
        event_registration_step_path(
          @event,
          handler.existing_registration,
          handler.existing_registration.last_step_seen
        ),
        notice: "We noticed you've already started a registration with this email. Here's the step you left off on!"
      )
    else
      create_new_registration
    end
  end

  def edit
  end

  def update
    @registration.step_to_validate = "start"
    if @registration.update(registration_params)
      redirect_to(
        event_registration_steps_path(@event, @registration)
      )
    else
      render :edit
    end
  end

  private

  def build_new_registration
    @event.registrations.new(started_at: Time.now, steps_seen: ["start"])
  end

  def build_new_participant_for(registration)
    @event.participants.new(registration: registration, race_id: params[:race_id])
  end

  def check_token
    if @registration.token != registration_token
      redirect_to danger_path
    end
  end

  def registration_params
    params.require(:registration).permit!
  end

  def registration_token
    params[:id].split("-").last
  end

  def set_event
    @event = Event.friendly.find params[:event_id]
  end

  def set_registration
    @registration = Registration.find(params[:id])
  end
end
