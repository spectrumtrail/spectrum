class RegistrationsController < ApplicationController
  before_action :set_event
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def new
    @registration = @event.registrations.new(started_at: Time.now)
    @participants = @registration.participants.new(race_id: params[:race_id])
  end

  def create
    @registration = @event.registrations.new(registration_params)
    if @registration.save
      redirect_to(
        # takes you to the registration steps wizard Details step
        registration_steps_path(token: @registration.token)
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
        registration_steps_path(token: @registration.token)
      )
    else
      render :edit
    end
  end

  def destroy
    redirect_to(
      root_path,
      danger: "Registrations cannot be destroyed. This attempt has been logged."
    )
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
