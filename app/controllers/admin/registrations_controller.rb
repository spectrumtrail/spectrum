class Admin::RegistrationsController < Admin::BaseController
  before_action :set_registration, only: [:edit, :update, :destroy, :show]
  before_action :set_race, :set_event

  # GET /registrations
  def index
    @registrations = @race.registrations.all
  end

  # GET /registrations/1
  def show
  end

  # GET /registrations/new
  def new
    @registration = Registration.new
  end

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations
  def create
    @registration = @race.registrations.new(registration_params)

    if @registration.save
      redirect_to admin_event_race_registration_path(@event, @race, @registration), notice: "Registration was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /registrations/1
  def update
    if @registration.update(registration_params)
      redirect_to admin_event_race_registration_path(@event, @race, @registration), notice: "Registration was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /registrations/1
  def destroy
    @registration.destroy
    redirect_to admin_event_race_registrations_path(@event, @race), notice: "Registration was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find_by_id params[:id]
    end

    def set_race
      @race = Race.find_by_id params[:race_id]
    end

    def set_event
      @event = Event.find_by_id params[:event_id]
    end

    # Only allow a trusted parameter "white list" through.
    def registration_params
      params.require(:registration).permit!
    end
end
