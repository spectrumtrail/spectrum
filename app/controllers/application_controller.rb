class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :set_menu_items
  around_action :set_time_zone

  private

  def after_sign_in_path_for(resource)
    members_profile_path
  end

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def set_time_zone(&block)
    Time.use_zone("Central Time (US & Canada)", &block)
  end

  def set_menu_items
    @menu_events = Event.is_active.order(:name)
    @menu_series = Series.is_active.order(:name)
  end
end
