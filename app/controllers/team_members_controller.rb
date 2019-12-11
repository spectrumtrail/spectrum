class TeamMembersController < ApplicationController
  def index
    @team_members = TeamMember.order(name: :asc)
    @leaders = @team_members.select { |member| member.is_leader == true }
    @blazers = @team_members.select { |member| member.is_leader == false }
  end

  def show
    @team_member = TeamMember.friendly.find(params[:id]).decorate
  end
end
