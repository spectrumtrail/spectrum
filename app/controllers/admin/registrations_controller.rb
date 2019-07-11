class Admin::RegistrationsController < Admin::BaseController
  before_action :set_registration, only: [:edit, :update, :destroy, :show]

  def index
    @registrations = Registration.includes(:payment, :participant)
    @registrations = @registrations.where(event_id: params[:event_id]) if params[:event_id].present?
    @registrations = @registrations.send(params.fetch(:filter_scope, :all)).order(created_at: :desc)

    @registrations = @registrations.page(params[:page]).per(50)
  end

  def show
    @participant = @registration.participant.decorate
    @payment = @registration.payment.try(:decorate)
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
    @registration = Registration.find(params[:id]).decorate
  end

  def registration_params
    params.require(:registration).permit!
  end
end
