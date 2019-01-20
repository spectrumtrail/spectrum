class Admin::LocationsController < Admin::BaseController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def show
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to(
        admin_locations_path,
        notice: "Location was successfully created."
      )
    else
      render :new
    end
  end

  def update
    if @location.update(location_params)
      redirect_to(
        admin_locations_path,
        notice: "Location was successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to(
      admin_locations_path,
      notice: "Location was successfully destroyed."
    )
  end

  private
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    def location_params
      params.require(:location).permit!
    end
end
