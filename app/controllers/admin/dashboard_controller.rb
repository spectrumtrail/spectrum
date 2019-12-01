class Admin::DashboardController < Admin::BaseController
  def show
    @races = Race.includes(:event).active.upcoming.by_starts_at.decorate
  end
end
