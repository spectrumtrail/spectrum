class Members::ProfileController < Members::BaseController
  def show
    @decorated_user = current_user.decorate
    @sponsor = Sponsor.all.sample
  end
end
