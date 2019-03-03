class Members::BaseController < ApplicationController
  before_action :authenticate_user!
  layout -> (controller) { controller.request.xhr? ? false : "members/base" }

  private

  def require_admin!
    unless current_user && current_user.is_admin?
      flash[:alert] = "Sorry, only Spectrum Admin users can go here."
      redirect_to root_path
    end
  end
  helper_method :require_admin!
end
