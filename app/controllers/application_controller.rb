class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :set_menu_items
  around_action :set_time_zone

  private

  def set_time_zone(&block)
    Time.use_zone("Central Time (US & Canada)", &block)
  end

  def set_menu_items
    @menu_events = Event.is_active.order(:name)
    @menu_series = Series.is_active.order(:name)
  end

  def require_admin!
    unless current_user && current_user.is_admin?
      flash[:alert] = "Sorry, only Spectrum Admin users can go here."
      redirect_to root_path
    end
  end
  helper_method :require_admin!
end
