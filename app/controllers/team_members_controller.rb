class TeamMembersController < ApplicationController
  def index
    @team_members = fetch_team_members
    @leaders = @team_members.select { |member| member.is_leader == true }
    @blazers = @team_members.select { |member| member.is_leader == false }
  end

  def show
    @team_member = TeamMember.friendly.find(params[:id]).decorate
  end

  private

  def fetch_team_members
    TeamMember.includes(:profile_image_attachment).order(name: :asc)
  end
end
