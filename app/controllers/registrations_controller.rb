class RegistrationsController < ApplicationController
  before_action :set_event
  before_action :set_registration, only: [:edit, :update]
  before_action :check_token, only: [:edit, :update]

  def new
    if @event.registration_open?(Time.current)
      @registration = build_new_registration
      @participant = build_new_participant_for(@registration)
    else
      redirect_to(
        event_path(@event),
        notice: "Registration is not open at this time!"
      )
    end
  end

  def create
    @registration = @event.registrations.new(registration_params)

    handler = NewRegistrationHandler.new(registration: @registration)

    if handler.existing_registration.present?
      resume_registration(handler.existing_registration)
    else
      create_new_registration(handler)
    end
  end

  def edit
  end

  def update
    @registration.step_to_validate = "start"
    if @registration.update(registration_params)
      redirect_to(
        event_registration_steps_path(@event, @registration),
        notice: "Registration progress saved!"
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

  def create_new_registration(handler)
    @registration = handler.create_new_registration

    if @registration.persisted?
      redirect_to(
        event_registration_steps_path(@event, @registration),
        notice: "Registration started! We will save your progress."
      )
    else
      render :new
    end
  end

  def registration_params
    params.require(:registration).permit!
  end

  def registration_token
    params[:id].split("-").last
  end

  def resume_registration(existing_registration)
    redirect_to(
      event_registration_step_path(
        @event,
        existing_registration,
        existing_registration.last_step_seen
      ),
      notice: "We noticed you've already started a registration with this email. Here's the step you left off on!"
    )
  end

  def set_event
    @event = Event.friendly.find(params[:event_id]).decorate
  end

  def set_registration
    @registration = Registration.find(params[:id]).decorate
  end
end
