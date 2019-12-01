class Admin::LocationsController < Admin::BaseController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.includes(:events, :cover_photo_attachment).order(:name).decorate
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
      flash[:success] = "Location was successfully created."
      redirect_to admin_locations_path
    else
      render :new
    end
  end

  def update
    if @location.update(location_params)
      flash[:success] = "Location was successfully updated."
      redirect_to admin_locations_path
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    flash[:success] = "Location was successfully removed."
    redirect_to admin_locations_path
  end

  private
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    def location_params
      params.require(:location).permit!
    end
end
