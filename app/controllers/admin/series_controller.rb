class Admin::SeriesController < Admin::BaseController
  before_action :set_series, only: [:show, :edit, :update, :destroy]

  def index
    @series = Series.order(:name).decorate
  end

  def show
  end

  def new
    @series = Series.new
  end

  def edit
  end

  def create
    @series = Series.new(series_params)

    if @series.save
      redirect_to(
        admin_series_path(@series),
        success: "Successfully created #{@series.name}"
      )
    else
      render :new
    end
  end

  def update
    if @series.update(series_params)
      redirect_to(
        admin_series_path(@series),
        success: "Successfully updated #{@series.name}"
      )
    else
      render :edit
    end
  end

  def destroy
    @series.destroy
    redirect_to(
      admin_series_path,
      success: "Successfully destroyed #{@series.name}"
    )
  end

  private

  def set_series
    @series = Series.friendly.find(params[:id])
  end

  def series_params
    params.require(:series).permit!
  end
end
