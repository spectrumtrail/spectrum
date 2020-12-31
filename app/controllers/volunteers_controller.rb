class VolunteersController < ApplicationController
  before_action :set_event

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    result = CreateVolunteer.new(volunteer: @volunteer).call
    if result.success
      redirect_to(event_volunteer_path(id: result.object.id), success: result.message)
    else
      flash[:error] = result.message
      redirect_back(fallback_location: new_event_volunteer_path, error: result.message)
    end
  end

  def show
    @volunteer = Volunteer.find(params[:id]).decorate
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:event_id, :volunteer_position_id, :time, :first_name, :last_name, :phone, :email)
  end

  def set_event
    @event = Event.friendly.find(params[:event_id]).decorate
  end
end
