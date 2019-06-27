class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :set_menu_items
  before_action :set_temporary_message
  around_action :set_time_zone

  private

  def after_sign_in_path_for(resource)
    if current_user.is_admin?
      admin_dashboard_path
    else
      members_profile_path
    end
  end

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def set_temporary_message
    unless current_user.present? || Rails.env.development?
      flash[:warning] = "Welcome to our new site! We are still in the process of implementing this big change, so worry not if something doesn't look right, or if your name is missing from a race start list. It will all get added soon!"
    end
  end

  def set_time_zone(&block)
    Time.use_zone("Central Time (US & Canada)", &block)
  end

  def set_menu_items
    @menu_events = Event.is_active.order(:starts_at)
  end
end
