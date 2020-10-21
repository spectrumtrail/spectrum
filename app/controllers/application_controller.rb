class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :set_menu_items, :set_drift_key
  around_action :set_time_zone
  after_action :track_action

  private

  def after_sign_in_path_for(resource)
    if current_user.is_admin?
      admin_main_dashboard_path
    else
      members_profile_path
    end
  end

  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  def set_time_zone(&block)
    Time.use_zone("Central Time (US & Canada)", &block)
  end

  def set_menu_items
    @menu_events ||= Event.includes(:location, :logo_attachment).
                           is_active.
                           order(:starts_at)
  end

  def set_drift_key
    gon.drift_key = ENV["DRIFT_ID"]
  end

  def set_froala_key
    gon.froala_key = ENV["FROALA_KEY"]
  end

  def track_action
    unless request.xhr?
      ahoy.track(
        "#{controller_name} ##{action_name}",
        request.path_parameters
      )
    end
  end
end
