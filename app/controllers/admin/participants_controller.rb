class Admin::ParticipantsController < Admin::BaseController
  before_action :set_registration, only: [:edit, :update, :destroy, :show]

  def index
    @participants = Participant.includes(:registration, :race)
  end

  def show
  end

  def new
    @participant = Participant.new
  end

  def edit
  end

  def create
    @participant = Participant.new(registration_params)

    if @participant.save
      redirect_to(
        admin_registration_path(@participant),
        notice: "Participant was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @participant.update(registration_params)
      redirect_to(
        admin_registration_path(@participant),
        notice: "Participant was successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    @participant.destroy
    redirect_to(
      admin_participants_path,
      notice: "Participant was successfully destroyed."
    )
  end

  private

  def set_registration
    @participant = Participant.find_by_id params[:id]
  end

  def registration_params
    params.require(:registration).permit!
  end
end
