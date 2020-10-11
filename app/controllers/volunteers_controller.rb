class VolunteersController < ApplicationController

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.create(volunteer_params)
    if @volunteer
      flash[:success] = 'Thank you for volunteering!'
      redirect_to root_path
    else
      flash[:error] = 'Error saving volunteer registration, please try again.'
      redirect_to new_volunteer_path
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:event_id, :first_name, :last_name, :phone, :email, :position, :time)
  end
end
