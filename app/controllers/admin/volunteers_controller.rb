class Admin::VolunteersController < Admin::BaseController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]

  def index
    @volunteers = fetch_volunteers
    @volunteers = @volunteers.page(params[:page])
  end

  def show
  end

  def new
    @volunteer = Volunteer.new
  end

  def edit
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)

    if @volunteer.save
      redirect_to(
        admin_volunteers_path(@volunteer),
        success: "Successfully created #{@volunteer.full_name}"
      )
    else
      render :new
    end
  end

  def update
    if @volunteer.update(volunteer_params)
      redirect_to(
        admin_volunteers_path,
        success: "Successfully updated #{@volunteer.full_name}"
      )
    else
      flash[:danger] = "Could not update this event. Please see errors."
      render :edit
    end
  end

  def destroy
    @volunteer.destroy
    redirect_to(
      admin_volunteers_path,
      success: "Successfully destroyed #{@volunteer.full_name}"
    )
  end

  private

  def fetch_volunteers
    volunteers = Volunteer.includes(:event)

    if params[:event_id].present?
      volunteers = volunteers.where(event_id: params[:event_id])
    end

    volunteers.send(
      params.fetch(:filter_scope, :all)
    ).order(created_at: :desc)
  end

  def set_volunteer
    @volunteer = Volunteer.find(params[:id]).decorate
  end

  def volunteer_params
    params.require(:volunteer).permit!
  end
end
