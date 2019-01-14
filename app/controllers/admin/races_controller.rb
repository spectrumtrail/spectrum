class Admin::RacesController < Admin::BaseController
  before_action :set_race, :set_event

  # GET /races
  def index
    @races = @event.races
  end

  # GET /races/1
  def show
  end

  # GET /races/new
  def new
    @race = Race.new
  end

  # GET /races/1/edit
  def edit
  end

  # POST /races
  def create
    @race = @event.races.new(race_params)

    if @race.save
      redirect_to admin_event_race_path(@event, @race), notice: "Race was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /races/1
  def update
    if @race.update(race_params)
      redirect_to admin_event_race_path(@event, @race), notice: "Race was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /races/1
  def destroy
    @race.destroy
    redirect_to admin_races_path, notice: "Race was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find_by_id params[:id]
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Only allow a trusted parameter "white list" through.
    def race_params
      params.require(:race).permit!
    end
end
