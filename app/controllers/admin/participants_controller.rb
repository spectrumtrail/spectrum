class Admin::ParticipantsController < Admin::BaseController
  before_action :set_participant, only: [:edit, :update, :destroy, :show]

  def index
    @q = Participant.includes(
      registration: [:payment, :race, :event]
    ).ransack(params[:q])

    @participants = @q.result.order(created_at: :desc).page(params[:page])

    respond_to do |format|
      format.html
      format.csv {
        event = Event.find params[:event_id]
        send_data(
          @participants.to_event_start_list_csv(event_id: params[:event_id]),
          filename: "#{event.name}-participants-#{Time.now.to_i}.csv"
        )
      }
    end
  end

  def show
  end

  def new
    @participant = Participant.new
  end

  def edit
  end

  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      redirect_to(
        admin_participant_path(@participant),
        notice: "Participant was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @participant.update(participant_params)
      redirect_to(
        admin_participant_path(@participant),
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

  def set_participant
    @participant = Participant.find_by_id params[:id]
  end

  def participant_params
    params.require(:participant).permit!
  end
end
