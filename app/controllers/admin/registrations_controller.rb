class Admin::RegistrationsController < Admin::BaseController
  before_action :set_registration, only: [:edit, :update, :destroy, :show]

  def index
    @registrations = Registration.all
  end

  def show
  end

  def new
    @registration = Registration.new
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      redirect_to(
        admin_registration_path(@registration),
        notice: "Registration was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to(
        admin_registration_path(@registration),
        notice: "Registration was successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    @registration.destroy
    redirect_to(
      admin_registrations_path,
      notice: "Registration was successfully destroyed."
    )
  end

  private

  def set_registration
    @registration = Registration.find_by_id params[:id]
  end

  def registration_params
    params.require(:registration).permit!
  end
end
