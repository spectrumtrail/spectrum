class Admin::TeamMembersController < Admin::BaseController
  before_action :set_team_member, only: [:edit, :update, :destroy]

  def index
    @team_members = TeamMember.order(name: :asc)
  end

  def new
    @team_member = TeamMember.new
  end

  def edit
  end

  def create
    @team_member = TeamMember.new(team_member_params)

    if @team_member.save
      redirect_to(
        admin_team_members_path,
        success: "#{@team_member.name} was successfully added to the team page!"
      )
    else
      flash[:danger] = "We could not create this team member. See errors."
      render :new
    end
  end

  def update
    if @team_member.update(team_member_params)
      redirect_to(
        admin_team_members_path,
        success: "#{@team_member.name} was successfully updated!"
      )
    else
      flash[:danger] = "We could not update this team member. See errors."
      render :edit
    end
  end

  def destroy
    @team_member.destroy
    redirect_to(
      admin_team_members_path,
      success: "TeamMember was successfully removed!"
    )
  end

  private

  def set_team_member
    @team_member = TeamMember.find(params[:id])
  end

  def team_member_params
    params.require(:team_member).permit!
  end
end
