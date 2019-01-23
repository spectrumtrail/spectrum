class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :info
  around_action :set_time_zone

  private

  # this will be replaced when we generate a users table
  def set_time_zone(&block)
    Time.use_zone("Central Time (US & Canada)", &block)
  end
end
