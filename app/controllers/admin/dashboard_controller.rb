class Admin::DashboardController < Admin::BaseController
  def show
    @races = Race.active.upcoming.by_starts_at.decorate
  end
end
