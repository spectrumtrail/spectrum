class RegistrationsController < ApplicationController
  before_action :set_event
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def new
    @registration = Registration.new
    @race = Race.find params[:race_id]
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      redirect_to @registration, notice: 'Registration was successfully created.'
    else
      render :new
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to @registration, notice: 'Registration was successfully updated.'
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
    # TODO: ENFORCE
    params.require(:registration).permit!
  end
end
