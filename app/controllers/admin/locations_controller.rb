class Admin::LocationsController < Admin::BaseController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  def index
    @locations = Location.all
  end

  # GET /locations/1
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to admin_locations_path, notice: "Location was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      redirect_to admin_locations_path, notice: "Location was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
    redirect_to admin_locations_path, notice: "Location was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :gps_lat, :gps_long, :address_text, :address_link, :allows_dogs, :spectator_entry_fee_text, :is_active)
    end
end
