class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  before_action :set_menu_items, :set_maps_key
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

  def set_time_zone(&block)
    Time.use_zone("Central Time (US & Canada)", &block)
  end

  def set_menu_items
    @menu_events = Event.with_attachments.is_active.order(:starts_at)
  end

  def set_maps_key
    gon.maps_key = Rails.application.credentials.send(Rails.env.to_sym).fetch(
      :google_maps_key,
      ENV["GOOGLE_MAPS_KEY"]
    )
  end
end
