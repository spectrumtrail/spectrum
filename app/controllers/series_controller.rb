class SeriesController < ApplicationController
  before_action :set_series, only: [:show, :edit, :update, :destroy]

  def index
    @series = Series.all
  end

  def show
  end

  private
    def set_series
      @series = Series.friendly.find(params[:id])
    end

    def series_params
      params.require(:series).permit!
    end
end
