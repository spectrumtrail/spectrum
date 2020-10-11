class VolunteersController < ApplicationController

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.create(volunteer_params)
    if @volunteer.errors.messages[:email]
      flash[:error] = @volunteer.errors.messages[:email][0]
      redirect_to new_volunteer_path
    elsif @volunteer.errors
      flash[:error] = @volunteer.errors.messages
      redirect_to new_volunteer_path
    else
      flash[:success] = 'Thank you for volunteering!'
      redirect_to root_path
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:event_id, :first_name, :last_name, :phone, :email, :position, :time)
  end
end
