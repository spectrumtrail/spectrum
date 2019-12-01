class Admin::RacesController < Admin::BaseController
  before_action :set_race, except: [:index, :new, :create]

  def index
    @races = Race.by_starts_at
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
        admin_races_path(@race),
        success: "#{@race.name_with_event} was successfully created!"
      )
    else
      flash[:danger] = "We could not create this race. See errors."
      render :new
    end
  end

  def update
    if @race.update(race_params)
      redirect_to(
        admin_races_path(@race),
        success: "#{@race.name_with_event} was successfully updated!"
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
      success: "Race was successfully destroyed!"
    )
  end

  def archive
    if archive_race.success?
      redirect_to(
        admin_races_path,
        success: "Race and its registrations successfully archived!"
      )
    end
  end

  private

  def archive_race
    ArchivesRace.new(race_id: @race.id).perform
  end

  def set_race
    @race = Race.friendly.find(params[:id]).decorate
  end

  def race_params
    params.require(:race).permit!
  end
end
