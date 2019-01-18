class Admin::RacesController < Admin::BaseController
  before_action :set_race, :set_event

  def index
    @races = @event.races
  end

  def show
  end

  def new
    @race = Race.new
  end

  def edit
  end

  def create
    @race = @event.races.new(race_params)

    if @race.save
      redirect_to(
        admin_event_race_path(@event, @race),
        notice: "Race was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @race.update(race_params)
      redirect_to(
        admin_event_race_path(@event, @race),
        notice: "Race was successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    @race.destroy
    redirect_to admin_races_path, notice: "Race was successfully destroyed."
  end

  private
    def set_race
      @race = Race.friendly.find params[:id]
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def race_params
      params.require(:race).permit!
    end
end
