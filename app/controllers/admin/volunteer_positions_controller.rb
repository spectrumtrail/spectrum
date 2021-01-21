class Admin::VolunteerPositionsController < Admin::BaseController
  before_action :set_volunteer_position, only: [:show, :edit, :update, :destroy]

  def index
    @volunteer_positions = fetch_volunteer_positions
    @volunteer_positions = @volunteer_positions.page(params[:page])
  end

  def show
  end

  def new
    @volunteer_position = VolunteerPosition.new
  end

  def edit
  end

  def create
    @volunteer_position = VolunteerPosition.new(volunteer_position_params)

    if @volunteer_position.save
      redirect_to(
        admin_volunteer_positions_path,
        success: "Successfully created #{@volunteer_position.name} for #{@volunteer_position.event.name}"
      )
    else
      render :new
    end
  end

  def update
    if @volunteer_position.update(volunteer_position_params)
      redirect_to(
        admin_volunteer_positions_path,
        success: "Successfully updated #{@volunteer_position.name} for #{@volunteer_position.event.name}"
      )
    else
      flash[:danger] = "Could not update this volunteer position. Please see errors."
      render :edit
    end
  end

  def destroy
    @volunteer_position.destroy
    redirect_to(
      admin_volunteer_positions_path,
      success: "Successfully destroyed #{@volunteer_position.name} for #{@volunteer_position.event.name}"
    )
  rescue ActiveRecord::InvalidForeignKey
    redirect_to(admin_volunteer_positions_path,
    error: "You will need to delete the associated volunteers before deleting this position"
    )
  end

  private

  def fetch_volunteer_positions
    volunteer_positions = VolunteerPosition.includes(:event).order("events.starts_at")

    if params[:event_id].present?
      volunteer_positions = volunteer_positions.where(event_id: params[:event_id])
    end

    volunteer_positions.send(
      params.fetch(:filter_scope, :all)
    )
  end

  def set_volunteer_position
    @volunteer_position = VolunteerPosition.find(params[:id])
  end

  def volunteer_position_params
    params.require(:volunteer_position).permit!
  end
end
