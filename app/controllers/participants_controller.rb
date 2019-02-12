class ParticipantsController < ApplicationController
  before_action :set_registration
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  def index
    @participants = @registration.participant
  end

  def show
  end

  def new
    @participant = @registration.participant.new
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
