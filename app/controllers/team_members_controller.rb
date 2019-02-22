class TeamMembersController < ApplicationController

  def index
    @team_members = TeamMember.order(name: :asc)
  end
end
