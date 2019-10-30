class TeamMembersController < ApplicationController

  def index
    @team_members = TeamMember.order(name: :asc)
    @leaders = @team_members.select { |member| member.is_leader == true }
    @blazers = @team_members.select { |member| member.is_leader == false }
  end
end
