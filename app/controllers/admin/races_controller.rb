class Admin::RacesController < Admin::BaseController
  before_action :set_race

  def index
    @races = Race.all
  end

  def show
  end

  def new
    @race = Race.new
  end

  def edit
  end

  def create
    @race = Race.new(race_params)

    if @race.save
      redirect_to(
        admin_race_path(@race),
        success: "Race was successfully created."
      )
    else
      flash[:danger] = "We could not create this race. See errors."
      render :new
    end
  end

  def update
    if @race.update(race_params)
      redirect_to(
        admin_event_race_path(@event, @race),
        success: "Race was successfully updated."
      )
    else
      flash[:danger] = "We could not update this race. See errors."
      render :edit
    end
  end

  def destroy
    @race.destroy
    redirect_to(
      admin_races_path,
      success: "Race was successfully destroyed."
    )
  end

  private

  def set_race
    @race = Race.find params[:id]
  end

  def race_params
    params.require(:race).permit!
  end
end
