class ParticipantsController < ApplicationController
  before_action :set_registration
  # before_action :check_for_token
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
    @participants = @registration.participants
  end

  def show
  end

  def new
    @participant = @registration.participants.new
  end

  def edit
  end

  def create
    @participant = @registration.particpants.new(participant_params)

    if @participant.save
      redirect_to(
        event_registration_path(@event, @registration),
        notice: "Participant was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @participant.update(participant_params)
      redirect_to(
        event_registration_path(@event, @registration),
        success: "Participant was successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    @participant.destroy
    redirect_to(
      event_registration_path(@event, @registration),
      success: "Participant was successfully destroyed."
    )
  end

  private

  def check_for_token
    if params.fetch(:token, nil) != @registration.token
      redirect_to new_event_registration_path(
        @event,
        danger: "You need the appropriate token to work with this registration.
         Please contact us if you are seeing this error and need help!"
      )
    end
  end

  def set_participant
    @participant = @registration.particpants.find(params[:id])
  end

  def set_registration
    @registration = Registration.find params[:registration_id]
    @event = @registration.event
  end

  def participant_params
    params.require(:participant).permit!
  end
end
